//
//  Courses.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/16/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "Attendance.h"
#import "Marks.h"

@class Attendance;

@interface Courses : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber * class_number;
@property (nonatomic, retain) NSString * course_code;
@property (nonatomic, retain) NSString * course_mode;
@property (nonatomic, retain) NSString * course_option;
@property (nonatomic, retain) NSString * course_title;
@property (nonatomic, retain) NSString * course_type;
@property (nonatomic, retain) NSString * faculty;
@property (nonatomic, retain) NSString * ltpc;
@property (nonatomic, retain) NSString * registration_status;
@property (nonatomic, retain) NSString * slot;
@property (nonatomic, retain) NSString * venue;
@property (nonatomic, retain) Attendance *attendance;
@property (nonatomic, retain) Marks *marks;
@property (nonatomic, retain) NSArray *timings;
@end
