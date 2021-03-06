//
//  HomeCollectionViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/15/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "RoundedHexagonPercentageView.h"
#import "GraphView.h"
#import "VITXManager.h"
#import "CCColorCube.h"
#import "ExpandedView.h"
#import "Marks.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Crashlytics/Answers.h>




@interface HomeCollectionViewController (){
    int choice;
}

@property (nonatomic) NSInteger selectedCell;
@property (nonatomic, strong) UICollectionViewFlowLayout *condensedLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *expandedLayout;
@property (nonatomic, strong) UIImageView *wallpaperView;
@property (nonatomic) NSInteger previouslySelectedCell; 
@property User *user;
@property (nonatomic) BOOL cellIsChanging;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"course";

#pragma mark <UICollectionViewDataSource>

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    UIColor *color;
    
    choice = [[VITXManager sharedManager] getAwesomeChoice];
    
    color = [[colorCube extractColorsFromImage:[[VITXManager sharedManager] getImagesArray:choice]
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
    
    self.selectedCell = -1;
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
         [self.collectionView reloadData];
         [[VITXManager sharedManager] hideLoadingIndicator];
         [self indexSubjectsIntoSpotlight];
         
     } error:^(NSError *error) {
         NSLog(@"Error in User subscription!");
     }];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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

- (void)indexSubjectsIntoSpotlight {
    
    if(![self.user.courses count]){
        NSLog(@"No Subjects to Index to Spotlight! Returning...");
        return;
    }
    
    
    @try {
        NSMutableArray *itemsToIndex = [[NSMutableArray alloc] init];
        
        for (Courses *course in self.user.courses){
            CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeText];
            
            attributeSet.title = course.course_title;
            NSString *description = [NSString stringWithFormat:@"Type: %@, Attendance: %@ percent", course.course_mode, course.attendance.attendance_percentage];
            
            if(!course.attendance.attendance_percentage){
                description = [NSString stringWithFormat:@"Type: %@", course.course_mode];
            }
            
            attributeSet.contentDescription = description;
            
            NSArray *keywords = [course.course_title componentsSeparatedByString:@" "];
            attributeSet.keywords = keywords;
            
            NSString *identifier = [NSString stringWithFormat:@"com.siddharth.%@%@", course.course_code, course.course_type];
            //NSLog(@"Using Identifier: %@", identifier);
            
            CSSearchableItem *item = [[CSSearchableItem alloc]initWithUniqueIdentifier:identifier domainIdentifier:@"com.siddharth" attributeSet:attributeSet];
            [itemsToIndex addObject:item];
        }
        
        
        
        [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"Deleted all current items before refreshing Spotlight Index.");
            [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:itemsToIndex completionHandler: ^(NSError * __nullable error2) {
                if (!error2){
                    NSLog(@"Subjects Now Indexed in Spotlight!");
                }
                else {
                    NSLog(@"Error Indexing Subjects!");
                }
            }];
        }];
        
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"Error Somewhere in the spotlight indexing");
        [Answers logCustomEventWithName:@"Error Indexing to Spotlight" customAttributes:@{}];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = CGPointMake(scrollView.bounds.origin.x,
                                self.collectionView.bounds.origin.y);
    CGRect newRect = self.collectionView.backgroundView.frame;
    newRect.origin = point;
    self.collectionView.backgroundView.frame = newRect;
    
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
        if(indexPath.row == self.selectedCell)
            return CGSizeMake(self.collectionView.bounds.size.width>500?500:self.collectionView.bounds.size.width,
                              self.collectionView.bounds.size.height);
        else
            return CGSizeMake(150, self.collectionView.bounds.size.height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.user.courses count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ExpandedView *view;
    
        for(UIView *view in [cell.contentView subviews])
        {
            [view removeFromSuperview];
        }
        
        
        if(indexPath.row == self.selectedCell)
        {
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ExpandedView" owner:self options:nil];
            
            view = [views firstObject];
            
            view.course = self.user.courses[indexPath.row];
            [cell.contentView addSubview:view];
            
            for(UIView *view in [cell.contentView subviews])
            {
                if(view.tag != 10)
                    view.alpha = 0;
            }
            
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 for(UIView *view in [cell.contentView subviews])
                                 {
                                     view.alpha = 1;
                                 }
                             }
                             completion:nil];
            
        }
        else
        {
            
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CondensedView" owner:self options:nil];
            
            view = [views firstObject];
            
            
            RoundedHexagonPercentageView *hexagonView = (RoundedHexagonPercentageView *)[view viewWithTag:1];
            
            hexagonView.transform = CGAffineTransformMakeRotation(M_PI/6+M_PI);
            hexagonView.center = CGPointMake(hexagonView.center.x,
                                             hexagonView.center.y-20);
            hexagonView.percentage = [[[self.user.courses[indexPath.row] attendance] attendance_percentage] floatValue];
            
            [cell.contentView addSubview:view];
            
            
            UILabel *courseCode = (UILabel *)[view viewWithTag:3];
            UILabel *courseTitle = (UILabel *)[view viewWithTag:4];
            UILabel *courseSlot = (UILabel *)[view viewWithTag:5];
            UILabel *attended = (UILabel *)[view viewWithTag:8];
            UILabel *conducted = (UILabel *)[view viewWithTag:9];
            
            
            courseCode.text = [self.user.courses[indexPath.row] course_code];
            courseTitle.text = [self.user.courses[indexPath.row] course_title];
            courseSlot.text = [self.user.courses[indexPath.row] slot];
            attended.text = [NSString stringWithFormat:@"%d", [[self.user.courses[indexPath.row] attendance] attended_classes].intValue];
            conducted.text = [NSString stringWithFormat:@"/ %d", [[self.user.courses[indexPath.row] attendance] total_classes].intValue];
            
            courseCode.textColor = self.view.tintColor;
            courseTitle.textColor = self.view.tintColor;
            courseSlot.textColor = self.view.tintColor;
            attended.textColor = self.view.tintColor;
            conducted.textColor = self.view.tintColor;
            
            

            
            if([courseSlot.text isEqualToString:@"NIL"]){
                courseSlot.text = @"";
            }
            
            
            if([self.user.courses count] > 1){
                GraphView *graphView = (GraphView *)[cell.contentView viewWithTag:2];

                if(indexPath.row>0 && indexPath.row < ([self.user.courses count] - 1))
                    [graphView setBefore:[[[self.user.courses[indexPath.row-1] attendance] attendance_percentage] floatValue]/100
                                 current:[[[self.user.courses[indexPath.row] attendance] attendance_percentage] floatValue]/100
                                   after:[[[self.user.courses[indexPath.row+1] attendance] attendance_percentage] floatValue]/100];
                else if(indexPath.row == 0)
                    [graphView setBefore:0.5
                                 current:[[[self.user.courses[indexPath.row] attendance] attendance_percentage] floatValue]/100
                                   after:[[[self.user.courses[indexPath.row+1] attendance] attendance_percentage] floatValue]/100];
                else
                    [graphView setBefore:[[[self.user.courses[indexPath.row-1] attendance] attendance_percentage] floatValue]/100
                                 current:[[[self.user.courses[indexPath.row] attendance] attendance_percentage] floatValue]/100
                                   after:0.5];
                
                graphView.lastUpdated = [[[[self.user.courses[indexPath.row] attendance] details] lastObject] date];
            
            }
            
            
            for(UIView *view in [cell.contentView subviews])
            {
                view.alpha = 0;
            }
            
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 for(UIView *view in [cell.contentView subviews])
                                 {
                                     view.alpha = 1;
                                 }
                                 hexagonView.center = CGPointMake(hexagonView.center.x,
                                                                  hexagonView.center.y + 20);
                             }
                             completion:nil];
            
            cell.backgroundColor = [UIColor clearColor];
            
            if(indexPath.row % 2 == 0)
                [cell viewWithTag:10].backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        }
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        if(!self.cellIsChanging)
        {
            self.cellIsChanging = YES;
            if(self.selectedCell == indexPath.row)
            {
                self.previouslySelectedCell = -1;
                return YES;
            }
            else
            {
                self.previouslySelectedCell = self.selectedCell;
                return YES;
            }
        }
        else
            return NO;
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    UICollectionViewCell *previousCell;
    
    if(self.previouslySelectedCell >= 0)
    {
        previousCell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.previouslySelectedCell inSection:1]];
    }
    

    if(indexPath.row == self.selectedCell)
    {
        self.selectedCell = -1;
    }
    else
    {
        self.selectedCell = indexPath.row;
    }
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         for(UIView *view in [cell.contentView subviews])
                         {
                             view.alpha = 0.0;
                         }
                         if(previousCell && [[collectionView visibleCells] containsObject:previousCell])
                         {
                             for(UIView *view in [previousCell.contentView subviews])
                             {
                                 view.alpha = 0.0;
                             }
                         }
                     }
                     completion:^(BOOL success){
                         for(UIView *view in [cell.contentView subviews])
                         {
                             view.hidden = YES;
                         }
                         if(previousCell && [[collectionView visibleCells] containsObject:previousCell])
                         {
                             for(UIView *view in [cell.contentView subviews])
                             {
                                 view.hidden = YES;
                             }
                         }
                         if(self.collectionView.collectionViewLayout == self.expandedLayout){
                              __unsafe_unretained typeof(self) weakSelf = self;
                             [self.collectionView setCollectionViewLayout:self.condensedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   
                                                                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                                   if(previousCell && [[collectionView visibleCells] containsObject:previousCell])
                                                                   {
                                                                       [collectionView reloadItemsAtIndexPaths:@[[collectionView indexPathForCell:previousCell]]];
                                                                   }
                                                                   
                                                                   weakSelf.cellIsChanging = NO;
                                                                   
                                                               }];
                         }
                         else{
                             __unsafe_unretained typeof(self) weakSelf = self;
                             [self.collectionView setCollectionViewLayout:self.expandedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   
                                                                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                                   if(previousCell && [[collectionView visibleCells] containsObject:previousCell])
                                                                   {
                                                                       [collectionView reloadItemsAtIndexPaths:@[[collectionView indexPathForCell:previousCell]]];
                                                                   }
                                                                   
                                                                   weakSelf.cellIsChanging = NO;
                                                                   
                                                               }];
                         }
                     }];
}
@end
