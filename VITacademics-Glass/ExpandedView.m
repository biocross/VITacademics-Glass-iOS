//
//  ExpandedView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 3/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "ExpandedView.h"

@implementation ExpandedView

//- (UIScrollView *)scrollView
//{
//    _scrollView.contentSize = CGSizeMake(1000, 1000);
//    NSLog(@"Getter used!");
//    return _scrollView;
//}



- (void)drawRect:(CGRect)rect {
    
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, 1000);
    
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 30, 30);
}




@end
