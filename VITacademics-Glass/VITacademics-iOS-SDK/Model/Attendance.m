//
//  Attendance.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/16/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "Attendance.h"


@implementation Attendance



+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSValueTransformer *)detailsJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AttendanceDetails class]];
}



@end


