//
//  GradedCourseObject.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 7/20/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface GradedCourseObject : MTLModel <MTLJSONSerializing>

@property NSString *course_title;
@property NSString *course_code;
@property NSString *course_type;
@property NSInteger credits;
@property NSString *grade;
@property NSDate *exam_held;
@property NSDate *result_date;
@property NSString *option;



@end
