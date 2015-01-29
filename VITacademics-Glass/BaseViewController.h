//
//  BaseViewController.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewController.h"
#import <MessageUI/MessageUI.h>
#import "TimeTableCollectionViewController.h"

@interface BaseViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) HomeCollectionViewController *homeScreenCollectionViewController;
@property (nonatomic, strong) TimeTableCollectionViewController *timeTableCollectionViewController;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *MenuButtons;
@property (strong, nonatomic) IBOutlet UIView *buttonsView;
- (IBAction)coursesPressed:(id)sender;
- (IBAction)timeTablePressed:(id)sender;
- (IBAction)credentialsPressed:(id)sender;
- (IBAction)feedbackPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *loadingIndicator;

-(void)showLoadingIndicator;
-(void)hideLoadingIndicator;


@end
