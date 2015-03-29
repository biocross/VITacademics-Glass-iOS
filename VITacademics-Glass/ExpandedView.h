//
//  ExpandedView.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 3/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Courses.h"
#import "RDVCalendarDayCell.h"
#import "RDVCalendarView.h"

@interface ExpandedView : UIView

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) Courses *course;

@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *slotLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet UILabel *attendedLabel;
@property (strong, nonatomic) IBOutlet UILabel *conductedLabel;
@property (nonatomic, strong) RDVCalendarView *calenderView;


@end
