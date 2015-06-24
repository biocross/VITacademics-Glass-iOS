//
//  TimingElement.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/24/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface TimingElement : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSNumber *day;
@property (nonatomic) NSDate *start_time;
@property (nonatomic) NSDate *end_time;

@end
