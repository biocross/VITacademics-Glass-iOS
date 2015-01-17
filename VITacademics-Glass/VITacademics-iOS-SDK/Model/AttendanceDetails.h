//
//  AttendanceDetails.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/21/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface AttendanceDetails : MTLModel <MTLJSONSerializing>

@property (nonatomic) BOOL status;
@property (nonatomic, retain) NSString *reason;
@property (nonatomic, retain) NSDate *date;




@end
