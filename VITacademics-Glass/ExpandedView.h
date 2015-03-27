//
//  ExpandedView.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 3/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Courses.h"

@interface ExpandedView : UIView

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) Courses *course;

@end
