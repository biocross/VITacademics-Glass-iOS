//
//  Marks.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/12/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "Marks.h"
#import "CBLMarks.h"
#import "PBLMarksElement.h"
#import "LBCMarks.h"


@implementation Marks

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    
    NSLog(@"reached class for JSOn");
    
    if(JSONDictionary[@"cat1"] != nil){
        NSLog(@"CBL subject");
        return CBLMarks.class;
    }
    
    if(JSONDictionary[@"details"] != nil){
        NSLog(@"PBL subject");
        return PBLMarksElement.class;
    }
    
    if(JSONDictionary[@"lab_cam"] != nil){
        NSLog(@"Lab subject");
        return LBCMarks.class;
    }
    
    NSAssert(NO, @"No matching class for the JSON dictionary '%@'.", JSONDictionary);
    return self;
}

@end
