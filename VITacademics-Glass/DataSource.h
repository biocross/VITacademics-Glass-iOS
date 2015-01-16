//
//  DataSource.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSArray *data;

@end
