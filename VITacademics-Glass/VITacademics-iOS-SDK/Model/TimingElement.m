//
//  TimingElement.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/24/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TimingElement.h"
#import "FTGValueTransformer.h"

@implementation TimingElement

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}


+ (NSValueTransformer *)dayJSONTransformer{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+(NSValueTransformer *)start_timeJSONTransformer{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm:ssZ";
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *dateStr) {
        return [dateFormatter dateFromString:dateStr];
    } reverseBlock:^(NSDate *date) {
        return [dateFormatter stringFromDate:date];
    }];
    
}

+(NSValueTransformer *)end_timeJSONTransformer{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm:ssZ";
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *dateStr) {
        return [dateFormatter dateFromString:dateStr];
    } reverseBlock:^(NSDate *date) {
        return [dateFormatter stringFromDate:date];
    }];
    
}


//Date conversion from UTC to IST
/*
 NSDateFormatter *df = [NSDateFormatter new];
 [df setDateFormat:@"HH:mm:ssZ"];
 df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
 NSDate *UTCDate = [df dateFromString:dateStr];
 df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:19800];
 NSString *localDateString = [df stringFromDate:UTCDate];
 NSLog(@"Recived: %@; converted: %@", dateStr, localDateString);
 
*/



@end
