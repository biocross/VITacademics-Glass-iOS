//
//  TimeTableCollectionViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/29/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TimeTableCollectionViewController.h"
#import "VITXManager.h"
#import "TimingElement.h"
#import "TimeTableDayView.h"



@interface TimeTableCollectionViewController (){
    NSArray *classes;
    int choice;
}


@property (nonatomic, strong) UICollectionViewFlowLayout *condensedLayout;
@property (nonatomic, strong) UIImageView *wallpaperView;
@property UIImage *wallpaper;

@end

@implementation TimeTableCollectionViewController

static NSString * const reuseIdentifier = @"DayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    choice = [[VITXManager sharedManager] getAwesomeChoice];
    self.wallpaper = [[VITXManager sharedManager] getBlurredImagesArray:choice];
    
    [self.collectionView setCollectionViewLayout:self.condensedLayout];
    self.collectionView.backgroundView  = self.wallpaperView;
    //[self.collectionView reloadData];
    
    [[RACObserve([VITXManager sharedManager], user)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(User *user) {
         if(!user){
             //courses view will call refresh
             //[[VITXManager sharedManager] startRefreshing];
         }
         self.user = user;
         
         [self initTimeTable];
         [[VITXManager sharedManager] hideLoadingIndicator];
         
     } error:^(NSError *error) {
         NSLog(@"Error in User subscription at TimeTable!");
     }];
}

-(void)initTimeTable{
    
    NSLog(@"INIT TIME TABLE CALLED");
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *todaysDay = [dateFormatter stringFromDate:[NSDate date]];
    
    
    if([todaysDay isEqualToString:@"Monday"]){
    }
    else if([todaysDay isEqualToString:@"Tuesday"]){
    }
    else if([todaysDay isEqualToString:@"Wednesday"]){
    }
    else if([todaysDay isEqualToString:@"Thursday"]){
    }
    else if([todaysDay isEqualToString:@"Friday"]){
    }
    else if([todaysDay isEqualToString:@"Saturday"]){
    }
    else{
    }
    
    
    //Init Days Array
    classes = @[[[NSMutableArray alloc] init],
                [[NSMutableArray alloc] init],
                [[NSMutableArray alloc] init],
                [[NSMutableArray alloc] init],
                [[NSMutableArray alloc] init],
                [[NSMutableArray alloc] init]];
    
    int subjectCount = [self.user.courses count];
    for(int i = 0; i < subjectCount; i++){
        int numberOfClassesPerWeek = [[self.user.courses[i] timings] count];
        for(int j = 0; j < numberOfClassesPerWeek; j++){
            NSDictionary *classInfo = [[NSDictionary alloc] init];
            TimingElement *element = [[self.user.courses[i] timings] objectAtIndex:j];
            int day = [element.day intValue];
            classInfo = @{
                          @"course": self.user.courses[i],
                          @"start": element.start_time,
                          @"end": element.end_time
                          };
            [classes[day] addObject:classInfo];
        }
    }
    [self.collectionView reloadData];
    //NSLog(@"Classes Epicness: %@", [classes description]);
}

- (UIImageView *)wallpaperView
{
    if(!_wallpaperView)
    {
        _wallpaperView = [[UIImageView alloc] initWithImage:self.wallpaper];
        _wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _wallpaperView;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UICollectionViewFlowLayout *)condensedLayout
{
    if(!_condensedLayout)
    {
        _condensedLayout = [[UICollectionViewFlowLayout alloc] init];
        [_condensedLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return _condensedLayout;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(165, self.collectionView.bounds.size.height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.contentView.clipsToBounds = YES;
    for(UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }

    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TimeTableCondensedView" owner:self options:nil];
    
    
    NSArray *days = @[@"MONDAY", @"TUESDAY", @"WEDNESDAY", @"THURSDAY", @"FRIDAY", @"SATURDAY"];
    
    TimeTableDayView *view = [views firstObject];
    [view setTimeTableForDay:classes[indexPath.row]];
    view.dayLabel.text = days[indexPath.row];
    [view reloadEverything];
    [cell.contentView addSubview:view];
    
    cell.backgroundColor = [UIColor clearColor];
    if(indexPath.row % 2 == 0)
        [cell viewWithTag:10].backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    
    return cell;
}


@end
