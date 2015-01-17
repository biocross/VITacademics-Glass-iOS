//
//  GraphView.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphView : UIView

@property (nonatomic) float currentValue;
@property (nonatomic) float beforeValue;
@property (nonatomic) float afterValue;

@property (nonatomic, strong) UIBezierPath *graphLinePath;
@property (nonatomic, strong) UIBezierPath *circlePath;

- (void) setBefore:(float) before
           current:(float) current
             after:(float) after;

@end
