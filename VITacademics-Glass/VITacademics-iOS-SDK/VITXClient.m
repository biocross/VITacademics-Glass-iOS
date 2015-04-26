//
//  VITXClient.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 1/2/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "VITXClient.h"
#import "User.h"
#import "LoginStatus.h"

@interface VITXClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation VITXClient

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSMutableURLRequest *)request {
    NSLog(@"VITXClient: Fetching Something.");
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (! jsonError) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"VITXClient: Error in fetchJSONFromURL: %@", error);
    }];
    
    
    return signal;
}

- (RACSignal *)refreshDataForUserWithRegistrationNumber:(NSString *)registrationNumber andDateOfBirth:(NSString *)dateOfBirth {
    NSString *campus = [[NSUserDefaults standardUserDefaults] stringForKey:@"campus"];
    NSString *mobile = [[NSUserDefaults standardUserDefaults] stringForKey:@"parentPhoneNumber"];
    NSString *urlString = [NSString stringWithFormat:@"https://vitacademics-rel.herokuapp.com/api/v2/%@/refresh", campus];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params = [NSString stringWithFormat:@"regno=%@&dob=%@&mobile=%@", registrationNumber, dateOfBirth, mobile];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [[self fetchJSONFromURL:urlRequest] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[User class] fromJSONDictionary:json error:nil];
    }];
}

- (RACSignal *)loginWithRegistrationNumber:(NSString *)registrationNumber andDateOfBirth:(NSString *)dateOfBirth {
    NSString *campus = [[NSUserDefaults standardUserDefaults] stringForKey:@"campus"];
    NSString *mobile = [[NSUserDefaults standardUserDefaults] stringForKey:@"parentPhoneNumber"];
    NSLog(@"%@, %@", campus, mobile);
    NSString *urlString = [NSString stringWithFormat:@"https://vitacademics-rel.herokuapp.com/api/v2/%@/login", campus];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params = [NSString stringWithFormat:@"regno=%@&dob=%@&mobile=%@", registrationNumber, dateOfBirth, mobile];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [[self fetchJSONFromURL:urlRequest] map:^(NSDictionary *json) {
        NSLog(@"JSON Received: %@", json );
        return [MTLJSONAdapter modelOfClass:[LoginStatus class] fromJSONDictionary:json[@"status"] error:nil];
    }];
}



@end
