//
//  Attendance.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/16/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "Courses.h"
#import "AttendanceDetails.h"


@interface Attendance : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSString * attendance_percentage;
@property (nonatomic, retain) NSString * attended_classes;
@property (nonatomic, retain) NSString * registration_date;
@property (nonatomic, retain) NSString * supported;
@property (nonatomic, retain) NSString * total_classes;
@property (nonatomic) AttendanceDetails * details;


@end
