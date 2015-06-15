//
//  MarksElement.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "MarksElement.h"
#import "FTGValueTransformer.h"

@implementation MarksElement

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

+ (NSValueTransformer *)max_marksJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)weightageJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)scored_marksJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)scored_percentageJSONTransformer{
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
