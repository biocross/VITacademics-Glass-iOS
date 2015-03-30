//
//  ExpandedView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 3/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "ExpandedView.h"
#import "CBLMarks.h"
#import "PBLMarksElement.h"
#import "LBCMarks.h"


@implementation ExpandedView

- (void)drawRect:(CGRect)rect {
    
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, 600);
    
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 30, 30);
    
    self.typeLabel.text = self.course.course_mode;
    self.slotLabel.text = self.course.slot;
    self.codeLabel.text = self.course.course_code;
    self.titleLabel.text = self.course.course_title;
    self.attendedLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.attended_classes.intValue];
    self.conductedLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.total_classes.intValue];
    self.percentageLabel.text = [NSString stringWithFormat:@"%d", self.course.attendance.attendance_percentage.intValue];
    
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
    
    if(self.course.CBLMarks){
        if(self.course.CBLMarks.cat1_status){
            self.mMarks1.text = [NSString stringWithFormat:@"%ld/50", (long)self.course.CBLMarks.cat1];
        }
        else{
            self.mMarks1.text = @"-";
            self.mMarks1.textColor = [UIColor lightGrayColor];
        }
        
        if(self.course.CBLMarks.cat2_status){
            self.mMarks2.text = [NSString stringWithFormat:@"%ld/50", (long)self.course.CBLMarks.cat2];
        }
        else{
            self.mMarks2.text = @"-";
            self.mMarks2.textColor = [UIColor lightGrayColor];
        }
        
        if(self.course.CBLMarks.quiz1_status){
            self.mMarks3.text = [NSString stringWithFormat:@"%ld/5", (long)self.course.CBLMarks.quiz1];
        }
        else{
            self.mMarks3.text = @"-";
            self.mMarks3.textColor = [UIColor lightGrayColor];
        }
        
        if(self.course.CBLMarks.quiz2_status){
            self.mMarks4.text = [NSString stringWithFormat:@"%ld/5", (long)self.course.CBLMarks.quiz2];
        }
        else{
            self.mMarks4.text = @"-";
            self.mMarks4.textColor = [UIColor lightGrayColor];
        }
        
        if(self.course.CBLMarks.quiz3_status){
            self.mMarks5.text = [NSString stringWithFormat:@"%ld/5", (long)self.course.CBLMarks.quiz3];
        }
        else{
            self.mMarks5.text = @"-";
            self.mMarks5.textColor = [UIColor lightGrayColor];
        }
        
        if(self.course.CBLMarks.assignment_status){
            self.mMarks6.text = [NSString stringWithFormat:@"%ld/5", (long)self.course.CBLMarks.assignment];
        }
        else{
            self.mMarks6.text = @"-";
            self.mMarks6.textColor = [UIColor lightGrayColor];
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