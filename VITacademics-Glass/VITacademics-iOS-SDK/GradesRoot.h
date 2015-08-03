//
//  GradesRoot.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 7/21/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface GradesRoot : MTLModel <MTLJSONSerializing>

@property NSArray *grades;
@property NSString *reg_no;


@end
