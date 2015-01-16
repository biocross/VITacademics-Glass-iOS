//
//  DataSource.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (NSArray *)data
{
    if(!_data)
    {
        _data = @[@75, @77, @88, @45, @100, @20, @84, @44, @87, @96, @10, @100];
    }
    return _data;
}






@end
