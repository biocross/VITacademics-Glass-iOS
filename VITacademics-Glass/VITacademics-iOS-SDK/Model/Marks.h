//
//  Marks.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface Marks : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSArray *assessments;

@end
