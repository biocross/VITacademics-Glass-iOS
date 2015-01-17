# VITacademics-iOS-SDK
iOS Wrapper for the VITacademics NodeJS Backend running on Heroku

Usage
======

Import VITManager.h, and use the following code to subscribe to the user object:
```
 [[RACObserve([VITXManager sharedManager], user)
    deliverOn:RACScheduler.mainThreadScheduler]
    subscribeNext:^(User *user) {
        if(!user){
            [[VITXManager sharedManager] startRefreshing];
        }
            NSLog(@"User: %@", user);
 }];
 ```
**You'll get the newest user object whenever it's updated**. The user object is **cached** after the first time. Call the method ```startRefreshing``` to get the latest data from the server.
 
**Please note:** The keys ```registrationNumber``` & ```dateOfBirth``` should exist in your ```[NSUserDefaults standardUserDefaults]``` for this to work. **You're free to make your own UI for getting these values.**
 
Dependencies
======
 The project **requires** the following Libraries:
 - ReactiveCocoa
 - Mantle
 
I recommend you use **CocoaPods** for the same.