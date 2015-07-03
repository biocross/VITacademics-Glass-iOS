//
//  AppDelegate.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/15/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "AppDelegate.h"
#import <SupportKit/SupportKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"78308c9ecfa82cc194ccebb197472ffe"];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator
     authenticateInstallation];
    
    [SupportKit initWithSettings:
    [SKTSettings settingsWithAppToken:@"3l84z9jlb16rr5m5mqpgniv76"]];
    
    [application setMinimumBackgroundFetchInterval:302400];
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
    }
    else
    {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSDate *fetchStart = [NSDate date];
    [[VITXManager sharedManager] fetchNewDataWithCompletionHandler:^(UIBackgroundFetchResult result) {
        completionHandler(result);
        
        NSDate *fetchEnd = [NSDate date];
        NSTimeInterval timeElapsed = [fetchEnd timeIntervalSinceDate:fetchStart];
        NSLog(@"Background Fetch: Duration -  %f seconds", timeElapsed);
        
        if(result == UIBackgroundFetchResultNewData){
            [self informUserAboutRefeshedAttendanceWithMessage:@"Your data has been refreshed! Check out what's newly uploaded."];
        }
        else if(result == UIBackgroundFetchResultFailed || result == UIBackgroundFetchResultNoData){
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            if(![prefs objectForKey:@"registrationNumber"]){
                [self informUserAboutRefeshedAttendanceWithMessage:@"Looks like you haven't started using VITacademics yet. Let's get started!"];
            }
        }
        
    }];
}

- (void)informUserAboutRefeshedAttendanceWithMessage: (NSString *)message{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray*    oldNotifications = [app scheduledLocalNotifications];
    
    if ([oldNotifications count] > 0)
        [app cancelAllLocalNotifications];
    
    UILocalNotification* alarm = [[UILocalNotification alloc] init];
    if (alarm)
    {
        alarm.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
        alarm.timeZone = [NSTimeZone localTimeZone];
        alarm.repeatInterval = 0;
        alarm.alertBody = message;
        
        [app scheduleLocalNotification:alarm];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
