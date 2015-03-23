//
//  LBCMarks.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/27/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "LBCMarks.h"
#import "FTGValueTransformer.h"

@implementation LBCMarks

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"LAB_internals" : @"lab_cam",
             @"status" : @"lab_cam_status"
             };
}

+ (NSValueTransformer *)LAB_internalsJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)statusJSONTransformer{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"": @(NO),
                                                                            @"Present": @(YES),
                                                                            @"Absent": @(NO),
                                                                            @"Debarred": @(NO)
                                                                            } defaultValue:@(YES) reverseDefaultValue:@"true"];
}

@end
