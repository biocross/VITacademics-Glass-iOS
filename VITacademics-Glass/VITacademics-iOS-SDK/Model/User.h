//
//  User.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/16/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "Courses.h"


@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSString *refreshed;
@property (nonatomic, retain) NSString * reg_no;
@property (nonatomic, retain) NSArray *courses;

@end
