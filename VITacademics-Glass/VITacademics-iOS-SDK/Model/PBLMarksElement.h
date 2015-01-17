//
//  PBLMarksElement.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/24/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface PBLMarksElement : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSString *title;
@property (nonatomic) NSInteger max_marks;
@property (nonatomic) NSInteger weightage;
@property (nonatomic, retain) NSDate *conducted_on;
@property (nonatomic) BOOL status;
@property (nonatomic) NSInteger scoredMark;
@property (nonatomic) NSInteger scoredPercent;

@end
