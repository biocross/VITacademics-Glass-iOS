//
//  VITXManager.m
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 1/2/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "VITXManager.h"

@interface VITXManager ()

@property (nonatomic, strong) VITXClient *client;
@property LoginStatus *status;
@property BOOL firstTime;

@end


@implementation VITXManager

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init {
    if (self = [super init]) {
        _client = [[VITXClient alloc] init];
        


//        NSAssert([[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"],
//                 @"Registration Number is required, Please set the key in your [NSUserDefaults standardUserDefaults]");
//        NSAssert([[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"],
//                 @"Date Of Birth (ddmmyyyy) is required, Please set the key in your [NSUserDefaults standardUserDefaults]");
//        

        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(startRefreshing)
         name:@"credentialsChanged"
         object:nil];

        if([[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime"]){
            self.firstTime = NO;
            [self loadData];
        }
        else{
            self.firstTime = YES;
        }
    }
    return self;
}

-(void)startRefreshing{
    
    NSLog(@"Started Refreshing: %@", self.client);
    
    /*
    NSAssert([[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"],
             @"Registration Number is required, Please set the key in your [NSUserDefaults standardUserDefaults]");
    NSAssert([[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"],
             @"Date Of Birth (ddmmyyyy) is required, Please set the key in your [NSUserDefaults standardUserDefaults]");
    
    NSLog(@"Passed Credential Assertions");
    */
    
    [self.baseViewController showLoadingIndicator];
    
    [[RACSignal
      merge:@[[self loginUser]]]
     subscribeCompleted:^{
         
         if([self.status.message containsString:@"Success"]){
             
             if(self.firstTime){
                 [[RACSignal
                   merge:@[[self reloadFirstTimeData]]]
                  subscribeCompleted:^{
                      NSLog(@"Loaded first time data");
                      [[NSNotificationCenter defaultCenter] postNotificationName:@"prepareViewsForDataPresentation" object:nil];
                  }];
                 
             }
             else{
                 [[RACSignal
                   merge:@[[self refreshData]]]
                  subscribeCompleted:^{
                      NSLog(@"Refreshing data");
                  }];
             }
         }
         else{
             NSLog(@"Login Failure");
         }
     }];
}

- (RACSignal *)reloadFirstTimeData {
    NSLog(@"Loading data for the first time.");
    
     return [[_client fetchFirstTimeForUserWithRegistrationNumber:[[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"] andDateOfBirth:[[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"]] doNext:^(User *user) {
        self.user = user;
        [self saveData];
         [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"firstTime"];
    }];
     
}

-(RACSignal *)loginUser{
    return [[_client loginWithRegistrationNumber:[[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"] andDateOfBirth:[[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"]] doNext:^(LoginStatus *status) {
        self.status = status;
    }];
}

- (RACSignal *)refreshData {
    return [[_client refreshDataForUserWithRegistrationNumber:[[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"] andDateOfBirth:[[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"]] doNext:^(User *user) {
        self.user = user;
        [self saveData];
    }];
}

-(void)saveData{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"]];
}

-(void)loadData{
    if(!self.firstTime){
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"]];
        self.user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    else{
        NSLog(@"Cannot load old data, it's the first time.");
    }
}

-(void)hideLoadingIndicator{
    [self.baseViewController hideLoadingIndicator];
}

-(void)showLoadingIndicator{
    [self.baseViewController showLoadingIndicator];
}

-(UIImage *)getAwesomeImage{
    NSArray *images = @[@"b1.jpg", @"b2.jpg", @"b3.jpg", @"b5.jpg", @"b6.jpg"];
    int choice = arc4random() % [images count];
    NSLog(@"%d", choice);
    return [UIImage imageNamed:images[choice]];
}

@end
