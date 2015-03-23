//
//  PBLMarksElement.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/24/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "PBLMarksElement.h"
#import "FTGValueTransformer.h"

@implementation PBLMarksElement

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

+ (NSValueTransformer *)max_marksJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)weightageJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)scoredMarkJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)scoredPercentJSONTransformer{
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

+(NSValueTransformer *)conducted_onJSONTransformer{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *dateStr) {
        return [dateFormatter dateFromString:dateStr];
    } reverseBlock:^(NSDate *date) {
        return [dateFormatter stringFromDate:date];
    }];
}

@end
