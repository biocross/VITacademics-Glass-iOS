//
//  TimeTableCollectionViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/29/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TimeTableCollectionViewController.h"
#import "VITXManager.h"



@interface TimeTableCollectionViewController (){
    NSArray *timeTable;
    NSMutableArray *classes;
    int choice;
}


@property (nonatomic, strong) UICollectionViewFlowLayout *condensedLayout;
@property (nonatomic, strong) UIImageView *wallpaperView;
@property UIImage *wallpaper;

@end

@implementation TimeTableCollectionViewController

static NSString * const reuseIdentifier = @"TimeTable";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    choice = [[VITXManager sharedManager] getAwesomeChoice];
    self.wallpaper = [[VITXManager sharedManager] getBlurredImagesArray:choice];
    
    [self.collectionView setCollectionViewLayout:self.condensedLayout];
    [self.collectionView reloadData];
    self.collectionView.backgroundView  = self.wallpaperView;
    
    
    
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
    return CGSizeMake(200, self.collectionView.bounds.size.height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
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

    UIView *view;
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TimeTableCondensedView" owner:self options:nil];
    view = [views firstObject];
    [cell.contentView addSubview:view];
    
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    if(indexPath.row % 2 == 0)
        [cell viewWithTag:10].backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    
    return cell;
}


@end
