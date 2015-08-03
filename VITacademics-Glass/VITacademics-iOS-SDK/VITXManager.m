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

        if([[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime_b8"]){
            self.firstTime = NO;
            [self loadData];
        }
        else{
            self.firstTime = YES;
        }
    }
    return self;
}

-(void)getGrades{
    NSLog(@"Getting Grades");
    [[RACSignal
      merge:@[[self loginUser]]]
     subscribeError:^(NSError *error) {
         if([[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime_b8"]){
         }
     } completed:^{
         @try{
             if([self.status.message isEqualToString:@"Successful execution"]){
                 [[RACSignal
                   merge:@[[self getGradesData]]]
                  subscribeCompleted:^{
                      NSLog(@"Grades JSON Received");
                  }];
             }
             else{
                 NSLog(@"Failed to get grades");
             }
         }
         @catch(NSException *e){
             NSLog(@"Exception In Grades login: %@", [e description]);
         }
     }];
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
     subscribeError:^(NSError *error) {
         [self.baseViewController hideLoadingIndicator];
         if([[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime_b8"]){
             [self.baseViewController showInfoToUserWithTitle:@"Network Error" andMessage:@"Please try again with a more stable internet connection."];
         }
         
     } completed:^{
         
         @try{
             NSLog(@"Status: %@", [self.status description]);
             
             if([self.status.message isEqualToString:@"Successful execution"]){
                 NSLog(@"entered here");
                 [[RACSignal
                   merge:@[[self refreshData]]]
                  subscribeCompleted:^{
                      NSLog(@"Refreshed Data");
                  }];
                 
             }
             else{
                 NSLog(@"Login Failure");
                 [self.baseViewController hideLoadingIndicator];
                 
                 if(!(self.status.message) || [self.status.message isEqualToString:@""]){
                     [self.baseViewController showInfoToUserWithTitle:@"Server Error" andMessage:@"Please try again"];
                 }
                 else{
                     [self.baseViewController showInfoToUserWithTitle:@"" andMessage:self.status.message];
                 }
                 
                 
             }
         }
         @catch(NSException *e){
             NSLog(@"Exception In Refresh: %@", [e description]);
         }
         
     }];
    
}


-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[RACSignal
      merge:@[[self loginUser]]]
     subscribeError:^(NSError *error) {
         NSLog(@"Background Fetch: Failed to login");
         completionHandler(UIBackgroundFetchResultFailed);
         
     } completed:^{
         @try{
             NSLog(@"Background Fetch: Logged in with Status: %@", [self.status description]);
             
             if([self.status.message isEqualToString:@"Successful execution"]){
                 [[RACSignal
                   merge:@[[self refreshData]]]
                  subscribeCompleted:^{
                      NSLog(@"Background Fetch: Refreshed & Saved Data");
                      completionHandler(UIBackgroundFetchResultNewData);
                  }];
                 
             }
             else{
                 NSLog(@"Background Fetch: Refresh Failure");
                 completionHandler(UIBackgroundFetchResultNoData);
             }
         }
         @catch(NSException *e){
             NSLog(@"Background Fetch: Exception In Refresh (try, catch): %@", [e description]);
             completionHandler(UIBackgroundFetchResultFailed);
         }
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

- (RACSignal *)getGradesData {
    return [[_client getGradesForRegistrationNumber:[[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"] andDateOfBirth:[[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"]] doNext:^(GradesRoot *grades) {
        self.gradesObject = grades;
    }];
}



-(void)saveData{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.user] forKey:[[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"]];
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

-(int)getAwesomeChoice{
    int choice = arc4random() % 5;
    return choice;
}

-(UIImage *)getImagesArray:(int)choice{
    NSArray *images = @[@"1.jpg", @"2.jpg", @"3.jpg", @"5.jpg", @"6.jpg"];
    return [UIImage imageNamed:images[choice]];
}

-(UIImage *)getBlurredImagesArray:(int)choice{
    NSArray *images = @[@"b1.jpg", @"b2.jpg", @"b3.jpg", @"b5.jpg", @"b6.jpg"];
    return [UIImage imageNamed:images[choice]];
}

@end
