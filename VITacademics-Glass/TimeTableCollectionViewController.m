//
//  TimeTableCollectionViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/29/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TimeTableCollectionViewController.h"

@interface TimeTableCollectionViewController (){
    NSArray *timeTable;
    NSMutableArray *classes;
}



@property (nonatomic, strong) UICollectionViewFlowLayout *condensedLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *expandedLayout;
@property (nonatomic, strong) UIImageView *wallpaperView;
@property User *user;
@property UIImage *wallpaper;

@end

@implementation TimeTableCollectionViewController

static NSString * const reuseIdentifier = @"TimeTable";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.wallpaper = [[VITXManager sharedManager] getAwesomeImage];
    [self.collectionView setCollectionViewLayout:self.condensedLayout];
    [self.collectionView reloadData];
    self.collectionView.backgroundView  = self.wallpaperView;
    
    [[RACObserve([VITXManager sharedManager], user)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(User *user) {
         if(!user){
             [[VITXManager sharedManager] startRefreshing];
         }
         //NSLog(@"User: %@", user);
         self.user = user;
         [self initTimeTable];
         
         [self.collectionView reloadData];
         [[VITXManager sharedManager] hideLoadingIndicator];
         
         
     }];
}



-(void)initTimeTable{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *todaysDay = [dateFormatter stringFromDate:[NSDate date]];
    
    
    if([todaysDay isEqualToString:@"Monday"]){
        timeTable = self.user.timetable.monday;
    }
    else if([todaysDay isEqualToString:@"Tuesday"]){
        timeTable = self.user.timetable.tuesday;
    }
    else if([todaysDay isEqualToString:@"Wednesday"]){
        timeTable = self.user.timetable.wednesday;
    }
    else if([todaysDay isEqualToString:@"Thursday"]){
        timeTable = self.user.timetable.thursday;
    }
    else if([todaysDay isEqualToString:@"Friday"]){
        timeTable = self.user.timetable.friday;
    }
    else if([todaysDay isEqualToString:@"Saturday"]){
        timeTable = self.user.timetable.saturday;
    }
    else{
        timeTable = self.user.timetable.monday;
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
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

- (UICollectionViewFlowLayout *)expandedLayout
{
    if(!_expandedLayout)
    {
        _expandedLayout = [[UICollectionViewFlowLayout alloc] init];
        _expandedLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _expandedLayout;
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

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(50, self.collectionView.bounds.size.height);
}


@end
