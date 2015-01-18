//
//  TimeTable.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 1/17/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface TimeTable : MTLModel <MTLJSONSerializing>

@property NSMutableArray *monday;
@property NSMutableArray *tuesday;
@property NSMutableArray *wednesday;
@property NSMutableArray *thursday;
@property NSMutableArray *friday;
@property NSMutableArray *saturday;


@end
