//
//  ExpandedView.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 3/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Courses.h"
#import "VRGCalendarView.h"

@interface ExpandedView : UIView <VRGCalendarViewDelegate>

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

@property (strong, nonatomic) IBOutlet UILabel *attendLabel;
@property (strong, nonatomic) IBOutlet UILabel *missLabel;

@property (strong, nonatomic) IBOutlet UIView *calendarSuperView;
- (IBAction)attendPlus:(id)sender;
- (IBAction)attendMinus:(id)sender;
- (IBAction)missPlus:(id)sender;
- (IBAction)missMinus:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *mTitle1;
@property (strong, nonatomic) IBOutlet UILabel *mTitle2;
@property (strong, nonatomic) IBOutlet UILabel *mTitle3;
@property (strong, nonatomic) IBOutlet UILabel *mTitle4;
@property (strong, nonatomic) IBOutlet UILabel *mTitle5;
@property (strong, nonatomic) IBOutlet UILabel *mMarks1;
@property (strong, nonatomic) IBOutlet UILabel *mMarks2;
@property (strong, nonatomic) IBOutlet UILabel *mMarks3;
@property (strong, nonatomic) IBOutlet UILabel *mMarks4;
@property (strong, nonatomic) IBOutlet UILabel *mMarks5;
@property (strong, nonatomic) IBOutlet UILabel *mTitle6;
@property (strong, nonatomic) IBOutlet UILabel *mMarks6;

@property (strong) VRGCalendarView *calendar;
@end
