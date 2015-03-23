//
//  CBLMarks.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/24/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "CBLMarks.h"
#import "FTGValueTransformer.h"

@implementation CBLMarks


+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

+ (NSValueTransformer *)cat1JSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)cat2JSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)quiz1JSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)quiz2JSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)quiz3JSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)assignmentJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)cat1_statusJSONTransformer{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"": @(NO),
                                                                            @"Present": @(YES),
                                                                            @"Absent": @(NO),
                                                                            @"Debarred": @(NO)
                                                                            } defaultValue:@(YES) reverseDefaultValue:@"true"];
}
+ (NSValueTransformer *)cat2_statusJSONTransformer{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"": @(NO),
                                                                            @"Present": @(YES),
                                                                            @"Absent": @(NO),
                                                                            @"Debarred": @(NO)
                                                                            } defaultValue:@(YES) reverseDefaultValue:@"true"];
}
+ (NSValueTransformer *)quiz1_statusJSONTransformer{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"": @(NO),
                                                                            @"Present": @(YES),
                                                                            @"Absent": @(NO),
                                                                            @"Debarred": @(NO)
                                                                            } defaultValue:@(YES) reverseDefaultValue:@"true"];
}
+ (NSValueTransformer *)quiz2_statusJSONTransformer{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"": @(NO),
                                                                            @"Present": @(YES),
                                                                            @"Absent": @(NO),
                                                                            @"Debarred": @(NO)
                                                                            } defaultValue:@(YES) reverseDefaultValue:@"true"];
}
+ (NSValueTransformer *)quiz3_statusJSONTransformer{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"": @(NO),
                                                                            @"Present": @(YES),
                                                                            @"Absent": @(NO),
                                                                            @"Debarred": @(NO)
                                                                            } defaultValue:@(YES) reverseDefaultValue:@"true"];
}
+ (NSValueTransformer *)assignment_statusJSONTransformer{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                            @"": @(NO),
                                                                            @"Present": @(YES),
                                                                            @"Absent": @(NO),
                                                                            @"Debarred": @(NO)
                                                                            } defaultValue:@(YES) reverseDefaultValue:@"true"];
}




@end
