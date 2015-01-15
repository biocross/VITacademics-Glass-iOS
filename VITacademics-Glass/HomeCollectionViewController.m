//
//  HomeCollectionViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/15/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "HomeCollectionViewController.h"
//#import "TestView.xib"

@interface HomeCollectionViewController ()

@property (nonatomic) NSInteger selectedCell;
@property (nonatomic, strong) UICollectionViewFlowLayout *condensedLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *expandedLayout;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"course";

#pragma mark <UICollectionViewDataSource>

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView setCollectionViewLayout:self.expandedLayout];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
    if(self.collectionView.collectionViewLayout == self.expandedLayout)
        return CGSizeMake(self.collectionView.bounds.size.width,
                          self.collectionView.bounds.size.height);
   else
        return CGSizeMake(125, self.collectionView.bounds.size.height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if(indexPath.row%2==0)
        cell.backgroundColor = [UIColor darkGrayColor];
    else
        cell.backgroundColor = [UIColor lightGrayColor];
    // Configure the cell
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:3];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         view.alpha = 0;
                     }
                     completion:^(BOOL success){
                         if(self.collectionView.collectionViewLayout == self.expandedLayout)
                             [self.collectionView setCollectionViewLayout:self.condensedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   view.backgroundColor = [UIColor greenColor];
                                                                   [UIView animateWithDuration:0.2
                                                                                    animations:^{view.alpha = 1.0;}];
                                                               }];
                         else
                             [self.collectionView setCollectionViewLayout:self.expandedLayout
                                                                 animated:YES
                                                               completion:^(BOOL success){
                                                                   view.backgroundColor = [UIColor redColor ];
                                                                   [UIView animateWithDuration:0.2
                                                                                    animations:^{view.alpha = 1.0;}];
                                                               }];
                     }];
}

@end
