//
//  VITXManager.h
//  VITacademics_version3
//
//  Created by Siddharth Gupta on 1/2/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "VITXClient.h"
#import "LoginStatus.h"
#import "BaseViewController.h"

@interface VITXManager : NSObject

+ (instancetype)sharedManager;
- (void)startRefreshing;

@property BaseViewController *baseViewController;

@property User *user;




/* Import VITManager.h, and use the following code to subscribe to the user object:

 [[RACObserve([VITXManager sharedManager], user)
    deliverOn:RACScheduler.mainThreadScheduler]
    subscribeNext:^(User *user) {
        if(!user){
            [[VITXManager sharedManager] startRefreshing];
        }
            NSLog(@"User: %@", user);
 }];
 
 You'll get the newest user object whenever it's updated. The user object is cached after the first time. Call the method 'startRefreshing' to get the latest data from the server.
 
 Please note: The keys "registrationNumber" & "dateOfBirth" should exist in your [NSUserDefaults standardUserDefaults] for this to work. You're free to make your own UI for getting these values.
 
 
*/

@end
