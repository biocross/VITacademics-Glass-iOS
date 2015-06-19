//
//  ExpandedView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 3/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "ExpandedView.h"
#import "Marks.h"
#import "MarksElement.h"

@implementation ExpandedView

- (void)drawRect:(CGRect)rect {
    
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, 1300);
    
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 30, 30);
    
    self.typeLabel.text = self.course.course_mode;
    self.slotLabel.text = self.course.slot;
    self.codeLabel.text = self.course.course_code;
    self.titleLabel.text = self.course.course_title;
    self.attendedLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.attended_classes.intValue];
    self.conductedLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.total_classes.intValue];
    self.percentageLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.attendance_percentage.intValue];
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    //calendar.delegate=self;
    calendar.backgroundColor = [UIColor clearColor];
    [self.calendarSuperView addSubview:calendar];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE, MMM dd, yyyy"];
    NSDate *date = [[self.course.attendance.details lastObject] date];
    NSString *dateString = [format stringFromDate:date];
    
    self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", dateString];
    
    if(!dateString){
        self.lastUpdatedLabel.text = @"-";
    }
    
    if(!self.course.slot){
        self.slotLabel.text = @"-";
    }
    else if([self.course.slot isEqualToString:@"NIL"]){
        self.slotLabel.text = @"-";
    }
    
    unsigned long count = [self.course.marks.assessments count];
    int i = 0;
    
    if(count){
        if(self.course.marks.assessments[i]){
            self.mTitle1.text = [self.course.marks.assessments[i] examTitle];
            self.mMarks1.text = [NSString stringWithFormat:@"%.1f/%.1f", [self.course.marks.assessments[i] scored_marks].floatValue, [self.course.marks.assessments[i] max_marks].floatValue];
        }
        else{
            self.mMarks1.text = @"-";
            self.mMarks1.textColor = [UIColor lightGrayColor];
        }
        i = i + 1;
        
        if(i < count){
            if([self.course.marks.assessments[i] examTitle]){
                self.mTitle2.text = [self.course.marks.assessments[i] examTitle];
                self.mMarks2.text = [NSString stringWithFormat:@"%.1f/%.1f", [self.course.marks.assessments[i] scored_marks].floatValue, [self.course.marks.assessments[i] max_marks].floatValue];
                                     }
            else{
                 self.mMarks2.text = @"-";
                 self.mMarks2.textColor = [UIColor lightGrayColor];
             }
            i = i + 1;
        }
        
        if(i < count){
            if([self.course.marks.assessments[i] examTitle]){
                self.mTitle3.text = [self.course.marks.assessments[i] examTitle];
                self.mMarks3.text = [NSString stringWithFormat:@"%.1f/%.1f", [self.course.marks.assessments[i] scored_marks].floatValue, [self.course.marks.assessments[i] max_marks].floatValue];
            }
            else{
                self.mMarks3.text = @"-";
                self.mMarks3.textColor = [UIColor lightGrayColor];
            }
            i = i + 1;
        }
        
        if(i < count){
            if([self.course.marks.assessments[i] examTitle]){
                self.mTitle4.text = [self.course.marks.assessments[i] examTitle];
                self.mMarks4.text = [NSString stringWithFormat:@"%.1f/%.1f", [self.course.marks.assessments[i] scored_marks].floatValue, [self.course.marks.assessments[i] max_marks].floatValue];
            }
            else{
                self.mMarks4.text = @"-";
                self.mMarks4.textColor = [UIColor lightGrayColor];
            }
            i = i + 1;
        }
        
        if(i < count){
            if([self.course.marks.assessments[i] examTitle]){
                self.mTitle5.text = [self.course.marks.assessments[i] examTitle];
                self.mMarks5.text = [NSString stringWithFormat:@"%.1f/%.1f", [self.course.marks.assessments[i] scored_marks].floatValue, [self.course.marks.assessments[i] max_marks].floatValue];
            }
            else{
                self.mMarks5.text = @"-";
                self.mMarks5.textColor = [UIColor lightGrayColor];
            }
            i = i + 1;
        }
        
        if(i < count){
            if([self.course.marks.assessments[i] examTitle]){
                self.mTitle6.text = [self.course.marks.assessments[i] examTitle];
                self.mMarks6.text = [NSString stringWithFormat:@"%.1f/%.1f", [self.course.marks.assessments[i] scored_marks].floatValue, [self.course.marks.assessments[i] max_marks].floatValue];
            }
            else{
                self.mMarks6.text = @"-";
                self.mMarks6.textColor = [UIColor lightGrayColor];
            }
            i = i + 1;
        }
    }

}

- (void)recalculateAttendance{
    float calculatedPercentage =(float) [self.attendedLabel.text intValue] / [self.conductedLabel.text intValue];
    float displayPercentageInteger = ceil(calculatedPercentage * 100);
    NSString *displayPercentage = [NSString stringWithFormat:@"%1.0f",displayPercentageInteger];
    self.percentageLabel.text = displayPercentage;
    
    if(displayPercentageInteger >= 80){
    }
    else if(displayPercentageInteger >= 75 && displayPercentageInteger < 80){
    }
    else{
    }
}


- (IBAction)attendPlus:(id)sender {
    int attendPlusLabel = [self.attendLabel.text intValue];
    [self.attendLabel setText:[NSString stringWithFormat:@"%d", attendPlusLabel + 1 ]];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"L" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.slotLabel.text options:0 range:NSMakeRange(0, [self.slotLabel.text length])];
    
    int numberOfSlots = 1;
    if(numberOfMatches){
        numberOfSlots = (int)numberOfMatches ;
    }
    
    int currentSubjectAttended = [self.attendedLabel.text intValue];
    [self.attendedLabel setText:[NSString stringWithFormat:@"%d", currentSubjectAttended + numberOfSlots]];
    
    int currentSubjectConducted = [self.conductedLabel.text intValue];
    [self.conductedLabel setText:[NSString stringWithFormat:@"%d", currentSubjectConducted + numberOfSlots ]];
    
    [self recalculateAttendance];
}

- (IBAction)attendMinus:(id)sender {
    int attendPlusLabel = [self.attendLabel.text intValue];
    if(attendPlusLabel > 0){
        [self.attendLabel setText:[NSString stringWithFormat:@"%d", attendPlusLabel - 1 ]];
        
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"L" options:NSRegularExpressionCaseInsensitive error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.slotLabel.text options:0 range:NSMakeRange(0, [self.slotLabel.text length])];
        
        int numberOfSlots = 1;
        if(numberOfMatches){
            numberOfSlots = (int)numberOfMatches;
        }
        
        int currentSubjectAttended = [self.attendedLabel.text intValue];
        [self.attendedLabel setText:[NSString stringWithFormat:@"%d", currentSubjectAttended - numberOfSlots]];
        
        int currentSubjectConducted = [self.conductedLabel.text intValue];
        [self.conductedLabel setText:[NSString stringWithFormat:@"%d", currentSubjectConducted - numberOfSlots]];
        
        [self recalculateAttendance];
    }
}

- (IBAction)missPlus:(id)sender {
    int missPlusLabel = [self.missLabel.text intValue] + 1;
    [self.missLabel setText:[NSString stringWithFormat:@"%d", missPlusLabel]];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"L" options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.slotLabel.text options:0 range:NSMakeRange(0, [self.slotLabel.text length])];
    
    int numberOfSlots = 1;
    if(numberOfMatches){
        numberOfSlots = (int)numberOfMatches;
    }
    
    
    int currentSubjectConducted = [self.conductedLabel.text intValue];
    [self.conductedLabel setText:[NSString stringWithFormat:@"%d", currentSubjectConducted + numberOfSlots ]];
    [self recalculateAttendance];
}

- (IBAction)missMinus:(id)sender {
    int missPlusLabel = [self.missLabel.text intValue];
    if(missPlusLabel > 0){
        [self.missLabel setText:[NSString stringWithFormat:@"%d", missPlusLabel - 1 ]];
        
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"L" options:NSRegularExpressionCaseInsensitive error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.slotLabel.text options:0 range:NSMakeRange(0, [self.slotLabel.text length])];
        
        int numberOfSlots = 1;
        if(numberOfMatches){
            numberOfSlots = (int)numberOfMatches;
        }
        
        int currentSubjectConducted = [self.conductedLabel.text intValue];
        [self.conductedLabel setText:[NSString stringWithFormat:@"%d", currentSubjectConducted - numberOfSlots ]];
        [self recalculateAttendance];
    }
}

@end
