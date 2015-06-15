//
//  Courses.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 12/16/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "Courses.h"



@implementation Courses


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
                @"marks": @"marks"
             };
}

+ (NSValueTransformer *)attendanceJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Attendance class]];
}

+(NSValueTransformer *)marksJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Marks class]];
}

//+ (NSValueTransformer *)CBLMarksJSONTransformer{
//    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CBLMarks class]];
//}
//
//+ (NSValueTransformer *)PBLMarksJSONTransformer{
//    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[PBLMarksElement class]];
//}
//
//+ (NSValueTransformer *)LBCMarksJSONTransformer{
//    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LBCMarks class]];
//}





@end
