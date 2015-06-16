//
//  MarksElement.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface MarksElement : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSString *examTitle;
@property (nonatomic) NSNumber *max_marks;
@property (nonatomic) NSNumber *weightage;
@property (nonatomic) NSString *conducted_on;
@property (nonatomic) BOOL status;
@property (nonatomic) NSNumber *scored_marks;
@property (nonatomic) NSNumber *scored_percentage;

@end
