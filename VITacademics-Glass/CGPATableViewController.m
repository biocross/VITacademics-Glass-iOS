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
    
    self.view.tintColor = [UIColor colorWithRed:red
                                          green:green
                                           blue:blue
                                          alpha:0.7];
    
    self.tableView.backgroundView = self.wallpaperView;
    
    
    [[RACObserve([VITXManager sharedManager], gradesObject)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(GradesRoot *grades) {
         if(!grades){
             [[VITXManager sharedManager] getGrades];
         }
         self.gradesObject = grades;
         self.grades = self.gradesObject.grades;
         [self.tableView reloadData];
         
     } error:^(NSError *error) {
         
     }];

    
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.grades.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = [self.grades[indexPath.row] course_title];
    
    return cell;
}

@end
