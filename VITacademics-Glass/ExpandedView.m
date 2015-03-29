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
    
    self.backgroundColor = [UIColor clearColor];
//    
//    self.typeLabel.text = self.course.course_type;
    self.slotLabel.text = self.course.slot;
    self.codeLabel.text = self.course.course_code;
    self.titleLabel.text = self.course.course_title;
    self.attendedLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.attended_classes.intValue];
    self.conductedLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.total_classes.intValue];
    self.percentageLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.attendance_percentage.intValue];
    
    
    self.calenderView = [[RDVCalendarView alloc] init];
    [self.calenderView registerDayCellClass:[RDVCalendarDayCell class]];
    
    self.calenderView.backButton.tintColor = [self tintColor];
    self.calenderView.forwardButton.tintColor = [self tintColor];
    self.calenderView.normalDayColor = [UIColor clearColor];
    
    self.calenderView.frame = CGRectMake(8, 550, 304, 304);
    [self.scrollView addSubview:self.calenderView];
}


@end
