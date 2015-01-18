//
//  TimeTable.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 1/17/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TimeTable.h"

@implementation TimeTable

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"monday" : @"mon",
             @"tuesday" : @"tue",
             @"wednesday" : @"wed",
             @"thursday" : @"thu",
             @"friday" : @"fri",
             @"saturday" : @"sat"
             };
}

+(NSValueTransformer *)mondayJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^id(NSMutableArray *array) {
        return array;
    }];
}

+(NSValueTransformer *)tuesdayJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^id(NSMutableArray *array) {
        return array;
    }];
}

+(NSValueTransformer *)wednesdayJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^id(NSMutableArray *array) {
        return array;
    }];
}

+(NSValueTransformer *)thursdayJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^id(NSMutableArray *array) {
        return array;
    }];
}

+(NSValueTransformer *)fridayJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^id(NSMutableArray *array) {
        return array;
    }];
}


+(NSValueTransformer *)saturdayJSONTransformer{
    return [MTLValueTransformer transformerWithBlock:^id(id array) {
        return array;
    }];
}


@end
