//
//  GradesRoot.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 7/21/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "GradesRoot.h"
#import "GradedCourseObject.h"

@implementation GradesRoot

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSValueTransformer *)gradesJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GradedCourseObject class]];
}


@end
