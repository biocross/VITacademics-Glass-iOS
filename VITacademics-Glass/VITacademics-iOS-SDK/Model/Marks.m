//
//  Marks.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "Marks.h"
#import "MarksElement.h"

@implementation Marks

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSValueTransformer *)assessmentsJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MarksElement class]];
}



@end
