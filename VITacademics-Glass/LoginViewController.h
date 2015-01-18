//
//  LoginViewController.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *regNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *dobTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
