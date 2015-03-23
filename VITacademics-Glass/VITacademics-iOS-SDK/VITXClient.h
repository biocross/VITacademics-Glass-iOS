//
//  VITXClient.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 1/2/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"


@interface VITXClient : NSObject

- (RACSignal *)refreshDataForUserWithRegistrationNumber:(NSString *)registrationNumber andDateOfBirth:(NSString *)dateOfBirth;
- (RACSignal *)loginWithRegistrationNumber:(NSString *)registrationNumber andDateOfBirth:(NSString *)dateOfBirth;
    
@end
