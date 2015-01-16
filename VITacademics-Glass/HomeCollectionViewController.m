//
//  HomeCollectionViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/15/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "UIImage+ImageEffects.h"
#import "DataSource.h"
#import "RoundedHexagonPercentageView.h"
#import "GraphView.h"

@interface HomeCollectionViewController ()

@property (nonatomic) NSInteger selectedCell;
@property (nonatomic, strong) UICollectionViewFlowLayout *condensedLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *expandedLayout;
@property (nonatomic, strong) UIImageView *wallpaperView;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"course";

#pragma mark <UICollectionViewDataSource>

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView setCollectionViewLayout:self.condensedLayout];
    [self.collectionView reloadData];
    
    [self addGestureRecogizersToCell];
    
    self.collectionView.backgroundView  = self.wallpaperView;
    
    
}

- (UIImageView *)wallpaperView
{
    if(!_wallpaperView)
    {
        _wallpaperView = [[UIImageView alloc]
                          initWithImage:[[UIImage imageNamed:@"wallpaper.jpg"] applyBlurWithRadius:20
                                                                                         tintColor:[UIColor colorWithRed:0
                                                                                                                   green:0
                                                                                                                    blue:0
                                                                                                                   alpha:0.5]
                                                                             saturationDeltaFactor:1.8
                                                                                         maskImage:nil]];
        _wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _wallpaperView;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView reloadData];
}

- (void) addGestureRecogizersToCell
{
    
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
    return [[DataSource sharedManager].data count];
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
        NSLog(@"Return empty cell");
    }
    else
    {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CondensedView" owner:self options:nil];
        
        view = [views firstObject];
        
        DataSource *source = [DataSource sharedManager];
        NSNumber *number = [source.data objectAtIndex:indexPath.row];
        
        RoundedHexagonPercentageView *hexagonView = (RoundedHexagonPercentageView *)[view viewWithTag:1];
        
        hexagonView.transform = CGAffineTransformMakeRotation(M_PI/6+M_PI);
        hexagonView.center = CGPointMake(hexagonView.center.x,
                                         hexagonView.center.y-20);
        hexagonView.percentage = number.floatValue;
        
        [cell.contentView addSubview:view];
        
        GraphView *graphView = (GraphView *)[cell.contentView viewWithTag:2];
        
        if(indexPath.row>0 && indexPath.row < 11)
            [graphView setBefore:((NSNumber *)[source.data objectAtIndex:(indexPath.row-1)]).floatValue/100
                         current:((NSNumber *)[source.data objectAtIndex:(indexPath.row)]).floatValue/100
                           after:((NSNumber *)[source.data objectAtIndex:(indexPath.row+1)]).floatValue/100];
        else if(indexPath.row == 0)
            [graphView setBefore:0.5
                         current:((NSNumber *)[source.data objectAtIndex:(indexPath.row)]).floatValue/100
                           after:((NSNumber *)[source.data objectAtIndex:(indexPath.row+1)]).floatValue/100];
        else
            [graphView setBefore:((NSNumber *)[source.data objectAtIndex:(indexPath.row-1)]).floatValue/100
                         current:((NSNumber *)[source.data objectAtIndex:(indexPath.row)]).floatValue/100
                           after:0.5];
        
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
    }
    
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    else
        cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    NSInteger previouslySelected = self.selectedCell;

    if(indexPath.row == self.selectedCell)
    {
        self.selectedCell = -1;
    }
    else
    {
        self.selectedCell = indexPath.row;
    }
    
    NSLog(@"Previously Selected Row: %ld",(long)previouslySelected);
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         for(UIView *view in [cell.contentView subviews])
                         {
                             view.alpha = 0.0;
                             
                         }
                     }
                     completion:^(BOOL success){
                         for(UIView *view in [cell.contentView subviews])
                         {
                             view.hidden = YES;
                         }
                         if(self.collectionView.collectionViewLayout == self.expandedLayout)
                             [self.collectionView setCollectionViewLayout:self.condensedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   
                                                                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                                   
                                                                   if(previouslySelected != indexPath.row && previouslySelected >= 0)
                                                                   {
                                                                       [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:previouslySelected inSection:0]]];
                                                                   }
                                                               }];
                         else
                             [self.collectionView setCollectionViewLayout:self.expandedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   
                                                                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                                   
                                                                   if(previouslySelected != indexPath.row)
                                                                   {
                                                                       [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:previouslySelected inSection:0]]];
                                                                   }
                                                               }];
                     }];
}

@end
