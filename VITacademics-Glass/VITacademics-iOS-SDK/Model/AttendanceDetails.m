//
//  AttendanceDetails.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/21/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "AttendanceDetails.h"

@implementation AttendanceDetails

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

+(NSValueTransformer *)dateJSONTransformer{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MMM-yyyy";
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *dateStr) {
        return [dateFormatter dateFromString:dateStr];
    } reverseBlock:^(NSDate *date) {
        return [dateFormatter stringFromDate:date];
    }];
            
}

 + (NSValueTransformer *)statusJSONTransformer {
     return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"Present": @(YES),
                                                                             @"Absent": @(NO),
                                                                             @"On Duty": @(YES)
                                                                        } defaultValue:@(YES) reverseDefaultValue:@"true"];
     
}


@end
