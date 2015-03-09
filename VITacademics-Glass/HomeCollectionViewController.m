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

@interface HomeCollectionViewController ()

@property (nonatomic) NSInteger selectedCell;
@property (nonatomic, strong) UICollectionViewFlowLayout *condensedLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *expandedLayout;
@property (nonatomic) NSInteger previouslySelectedCell;
@property (nonatomic) BOOL cellIsChanging;
@property User *user;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"course";

#pragma mark <UICollectionViewDataSource>

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tintColor = [UIColor colorWithRed:0.32 green:0.85 blue:0.36 alpha:1];
    
    self.selectedCell = -1;
    [self.collectionView setCollectionViewLayout:self.condensedLayout];
    [self.collectionView reloadData];

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
         
     }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
    UIView *view;
    
        for(UIView *view in [cell.contentView subviews])
        {
            [view removeFromSuperview];
        }
        
        
        if(indexPath.row == self.selectedCell)
        {
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ExpandedView" owner:self options:nil];
            
            view = [views firstObject];
            
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
            [view viewWithTag:1].transform = CGAffineTransformMakeRotation(M_PI/6);
            
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
            
            courseCode.text = [self.user.courses[indexPath.row] course_code];
            courseTitle.text = [self.user.courses[indexPath.row] course_title];
            courseSlot.text = [self.user.courses[indexPath.row] slot];
            
            courseCode.textColor = self.view.tintColor;
            courseTitle.textColor = self.view.tintColor;
            courseSlot.textColor = self.view.tintColor;
            
            

            
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
            
            cell.backgroundColor = [UIColor colorWithRed:0.16 green:0.17 blue:0.21 alpha:1];
            
            if(indexPath.row % 2 == 0)
                [cell viewWithTag:10].backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.20 alpha:1];
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

    /*
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
                         if(self.collectionView.collectionViewLayout == self.expandedLayout)
                             [self.collectionView setCollectionViewLayout:self.condensedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   
                                                                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                                   if(previousCell && [[collectionView visibleCells] containsObject:previousCell])
                                                                   {
                                                                       [collectionView reloadItemsAtIndexPaths:@[[collectionView indexPathForCell:previousCell]]];
                                                                   }
                                                                   
                                                                   self.cellIsChanging = NO;
                                                                   
                                                               }];
                         else
                             [self.collectionView setCollectionViewLayout:self.expandedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   
                                                                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                                   if(previousCell && [[collectionView visibleCells] containsObject:previousCell])
                                                                   {
                                                                       [collectionView reloadItemsAtIndexPaths:@[[collectionView indexPathForCell:previousCell]]];
                                                                   }
                                                                   
                                                                   self.cellIsChanging = NO;
                                                                   
                                                               }];
                     }];
     */
}
@end
