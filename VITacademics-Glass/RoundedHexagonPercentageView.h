//
//  RoundedHexagonPercentageView.h
//  VITacademics-Glass
//
//  Created by Pratham Mehta on 16/01/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundedHexagonPercentageView : UIView

@property (nonatomic, strong) UIBezierPath *hexagonPath;
@property (nonatomic) float percentage;
@property (nonatomic, strong) UILabel *percentageLabel;
@property (nonatomic, strong) UIView *hexagonSuperView;



@end
