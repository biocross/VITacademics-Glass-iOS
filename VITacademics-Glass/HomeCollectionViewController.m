//
//  HomeCollectionViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/15/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "UIImage+ImageEffects.h"

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
        _wallpaperView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"wallpaper.jpg"] applyBlurWithRadius:20
                                                                                                             tintColor:[UIColor clearColor]
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
        return CGSizeMake(500,
                          self.collectionView.bounds.size.height);
   else
        return CGSizeMake(150, self.collectionView.bounds.size.height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    for(UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CondensedView" owner:self options:nil];
    UIView *view = [views firstObject];
    
    UIView *hexagonView = [view viewWithTag:1];
    
    [UIView animateWithDuration:0.6 animations:^{hexagonView.transform = CGAffineTransformMakeRotation(M_PI_2*3);}];
    
    [cell.contentView addSubview:view];
    
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    else
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    self.selectedCell = indexPath.row;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         for(UIView *view in [cell.contentView subviews])
                         {
                             view.alpha = 0.0;
                         }
                     }
                     completion:^(BOOL success){
                         if(self.collectionView.collectionViewLayout == self.expandedLayout)
                             [self.collectionView setCollectionViewLayout:self.condensedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   [UIView animateWithDuration:0.2
                                                                                    animations:^{
                                                                                        for(UIView *view in [cell.contentView subviews])
                                                                                        {
                                                                                            view.alpha = 1.0;
                                                                                        }
                                                                                    }];
                                                               }];
                         else
                             [self.collectionView setCollectionViewLayout:self.expandedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   [UIView animateWithDuration:0.2
                                                                                    animations:^{
                                                                                        for(UIView *view in [cell.contentView subviews])
                                                                                        {
                                                                                            view.alpha = 1.0;
                                                                                        }
                                                                                    }];
                                                               }];
                     }];
}

@end
