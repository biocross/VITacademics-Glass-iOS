//
//  LoginStatus.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 1/2/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "Mantle.h"

@interface LoginStatus : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * code;

@end
