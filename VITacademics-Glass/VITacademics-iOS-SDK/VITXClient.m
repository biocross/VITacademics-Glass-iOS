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

- (RACSignal *)fetchJSONFromURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"VITXClient: Fetching: %@",url.absoluteString);
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
        NSLog(@"%@",error);
    }];
    
    
    return signal;
}

- (RACSignal *)fetchFirstTimeForUserWithRegistrationNumber:(NSString *)registrationNumber andDateOfBirth:(NSString *)dateOfBirth {
    NSString *campus = [[NSUserDefaults standardUserDefaults] stringForKey:@"campus"];
    NSString *url = [NSString stringWithFormat:@"http://vitacademics-rel.herokuapp.com/api/%@/data/first?regno=%@&dob=%@", campus, registrationNumber, dateOfBirth];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[User class] fromJSONDictionary:json error:nil];
    }];
}

- (RACSignal *)refreshDataForUserWithRegistrationNumber:(NSString *)registrationNumber andDateOfBirth:(NSString *)dateOfBirth {
    NSString *campus = [[NSUserDefaults standardUserDefaults] stringForKey:@"campus"];
    NSString *url = [NSString stringWithFormat:@"http://vitacademics-rel.herokuapp.com/api/%@/data/refresh?regno=%@&dob=%@", campus, registrationNumber, dateOfBirth];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[User class] fromJSONDictionary:json error:nil];
    }];
}

- (RACSignal *)loginWithRegistrationNumber:(NSString *)registrationNumber andDateOfBirth:(NSString *)dateOfBirth {
    NSString *campus = [[NSUserDefaults standardUserDefaults] stringForKey:@"campus"];
    NSString *url = [NSString stringWithFormat:@"http://vitacademics-rel.herokuapp.com/api/%@/login/auto?regno=%@&dob=%@", campus, registrationNumber, dateOfBirth];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[LoginStatus class] fromJSONDictionary:json[@"status"] error:nil];
    }];
}



@end
