//
//  CGPATableViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 4/3/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "CGPATableViewController.h"

@interface CGPATableViewController (){
    int choice;
    NSMutableArray *credits;
    NSMutableArray *gradeValues ;
    
}

@property (nonatomic, strong) UIImageView *wallpaperView;
@property NSArray *grades;
@property GradesRoot *gradesObject;


@end

@implementation CGPATableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    choice = [[VITXManager sharedManager] getAwesomeChoice];
    
    UIColor *color = [[colorCube extractColorsFromImage:[[VITXManager sharedManager] getImagesArray:choice]
                                         flags:CCAvoidBlack|CCOnlyBrightColors|CCOrderByBrightness
                                         count:3] firstObject];
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.view.tintColor = [UIColor colorWithRed:red
                                          green:green
                                           blue:blue
                                          alpha:0.7];
    
    [self.view addSubview:self.wallpaperView];
    [self.view bringSubviewToFront:self.tableView];
    [self.view bringSubviewToFront:self.currentToolbar];
    [self.view bringSubviewToFront:self.expectedToolbar];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    [[RACObserve([VITXManager sharedManager], gradesObject)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(GradesRoot *grades) {
         if(!grades){
             [[VITXManager sharedManager] getGrades];
         }
         self.gradesObject = grades;
         self.grades = self.gradesObject.grades;
         [self sanitizeGrades];
         
     } error:^(NSError *error) {
         NSLog(@"Error Subscribing to Grades");
     }];

    
}

- (void)sanitizeGrades{
    NSLog(@"Original Array Count: %lu", (unsigned long)[self.grades count]);

    NSMutableArray *sanitizedGrades = [[NSMutableArray alloc] initWithArray:self.grades];
    
    
    int count = (int)[sanitizedGrades count];
    for(int i = 0; i < count; i++){
        GradedCourseObject *course = sanitizedGrades[i];
        if([course.grade isEqualToString:@"W"] || [course.grade isEqualToString:@"P"]){
            [sanitizedGrades removeObjectAtIndex:i];
            count = count - 1;
        }
    }
    
    for(int i = 0; i < count-1; i++){
        GradedCourseObject *currentCourse = sanitizedGrades[i];
        GradedCourseObject *nextCourse = sanitizedGrades[i+1];
        //NSLog(@"Comparing %@ (%@) with %@ (%@)", currentCourse.course_title, currentCourse.grade, nextCourse.course_title, nextCourse.grade);
        if([currentCourse.course_title isEqualToString:nextCourse.course_title] && [currentCourse.course_type isEqualToString:nextCourse.course_type]){
            [sanitizedGrades removeObjectAtIndex:(i+1)];
            //NSLog(@"Removed %@ (%@)", nextCourse.course_title, nextCourse.grade);
            i = i - 1;
            count = count - 1;
        }
    }
    
    NSLog(@"Sanitized Array Count: %lu", (unsigned long)[sanitizedGrades count]);
    self.grades = sanitizedGrades;
    
    credits = [[NSMutableArray alloc] init];
    gradeValues = [[NSMutableArray alloc] init];
    
    int count2 = (int)[self.grades count];
    for(int i = 0; i < count2; i++){
        GradedCourseObject *course = self.grades[i];
        [credits addObject:[NSNumber numberWithInt:course.credits]];
        [gradeValues addObject:[self getValueOfGrade:course.grade]];
    }
    [self recalculateCGPA];
    [self.tableView reloadData];
}

- (NSNumber *)getValueOfGrade:(NSString *)grade {
    if([grade isEqualToString:@"N"]){
        return [NSNumber numberWithInt:0];
    }
    else if([grade isEqualToString:@"F"]){
        return [NSNumber numberWithInt:0];
    }
    else if([grade isEqualToString:@"E"]){
        return [NSNumber numberWithInt:5];
    }
    else if([grade isEqualToString:@"D"]){
        return [NSNumber numberWithInt:6];
    }
    else if([grade isEqualToString:@"C"]){
        return [NSNumber numberWithInt:7];
    }
    else if([grade isEqualToString:@"B"]){
        return [NSNumber numberWithInt:8];
    }
    else if([grade isEqualToString:@"A"]){
        return [NSNumber numberWithInt:9];
    }
    else if([grade isEqualToString:@"S"]){
        return [NSNumber numberWithInt:10];
    }
    else{
        return [NSNumber numberWithInt:0];
    }
}

- (UIImageView *)wallpaperView
{
    if(!_wallpaperView)
    {
        _wallpaperView = [[UIImageView alloc] initWithImage:[[VITXManager sharedManager] getBlurredImagesArray:choice]];
        _wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _wallpaperView;
}

- (void)recalculateCGPA {
    
    long creditsCount = [credits count];
    long gradeValuesCount = [gradeValues count];
    
    if(creditsCount == 0){
        return;
    }
    
    if(creditsCount != gradeValuesCount){
        NSLog(@"Array counts not equal! Failed CGPA Calculation");
        return;
    }
    
    float numerator = 0;
    float denominator = 0;
    
    for(int i = 0; i < creditsCount; i++){
        denominator += [credits[i] intValue];
        numerator += ([credits[i] intValue] * [gradeValues[i] intValue]);
    }
    
    NSLog(@"Calculation: %f / %f", numerator, denominator);
    float CGPA = numerator/denominator;
    self.expectedCGPA.title = [NSString stringWithFormat:@"%f", CGPA];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.grades.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"GradeCell"];
    cell.detailTextLabel.text = [self.grades[indexPath.row] course_title];
    cell.textLabel.text = [self.grades[indexPath.row] grade];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
