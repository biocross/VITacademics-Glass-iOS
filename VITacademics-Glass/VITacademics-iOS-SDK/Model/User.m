//
//  User.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/16/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "User.h"
#import "Mantle.h"
#import "Courses.h"


@implementation User


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}


+ (NSValueTransformer *)coursesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Courses class]];
}

/*+ (NSValueTransformer *)refreshedJSONTransformer{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"eee, dd MMM yyyy HH:mm:ss ZZZZ"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZZ"];
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *dateStr) {
        return [dateFormatter dateFromString:dateStr];
    } reverseBlock:^(NSDate *date) {
        return [dateFormatter stringFromDate:date];
    }];
}*/



@end
