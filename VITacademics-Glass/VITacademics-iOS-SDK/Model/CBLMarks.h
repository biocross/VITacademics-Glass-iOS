//
//  CBLMarks.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/24/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface CBLMarks : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSNumber *cat1;
@property (nonatomic) BOOL cat1_status;
@property (nonatomic) NSNumber *cat2;
@property (nonatomic) BOOL cat2_status;
@property (nonatomic) NSNumber *quiz1;
@property (nonatomic) BOOL quiz1_status;
@property (nonatomic) NSNumber *quiz2;
@property (nonatomic) BOOL quiz2_status;
@property (nonatomic) NSNumber *quiz3;
@property (nonatomic) BOOL quiz3_status;
@property (nonatomic) NSNumber *assignment;
@property (nonatomic) BOOL assignment_status;




@end
