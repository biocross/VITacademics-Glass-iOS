//
//  LoginViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "LoginViewController.h"
#import "VITXManager.h"




@interface LoginViewController (){
    UIDatePicker *datePicker;
}
@property UIImageView *wallpaperView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"campus"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"vellore" forKey:@"campus"];
    }
    
    UITapGestureRecognizer *responders = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllFirstResponders:)];
    [self.view addGestureRecognizer:responders];
    
    self.regNoTextField.delegate = self;
    self.dobTextField.delegate = self;
     datePicker = [[UIDatePicker alloc] init];
    
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"]){
        self.regNoTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"];
    }
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"]){
        self.dobTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"];
    }
    
    _wallpaperView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _wallpaperView.contentMode = UIViewContentModeLeft;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        _wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    int choice = [[VITXManager sharedManager] getAwesomeChoice];
    _wallpaperView.image = [[VITXManager sharedManager] getBlurredImagesArray:choice];
    [self.view insertSubview:_wallpaperView atIndex:0];
    
    if ([self.regNoTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.regNoTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Registration Number" attributes:@{NSForegroundColorAttributeName: color}];
        self.dobTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date Of Birth" attributes:@{NSForegroundColorAttributeName: color}];
        self.parentPhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Parent Phone Number" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    [self.campusSelector addTarget:self
                            action:@selector(selectCampus:)
               forControlEvents:UIControlEventValueChanged];
    
    self.closeButton.enabled = NO;
    self.closeButton.hidden = YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs objectForKey:@"registrationNumber"] && [prefs objectForKey:@"dateOfBirth"]){
        self.closeButton.enabled = YES;
        self.closeButton.hidden = NO;
    }
}

-(void)dismissAllFirstResponders:(id)sender{
    [self.regNoTextField resignFirstResponder];
    [self.dobTextField resignFirstResponder];
    [self.parentPhoneNumber resignFirstResponder];
}

-(void)selectCampus:(UISegmentedControl *)sender{
    NSInteger choice = [sender selectedSegmentIndex];
    if(!choice){
        [[NSUserDefaults standardUserDefaults] setObject:@"vellore" forKey:@"campus"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@"chennai" forKey:@"campus"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonPressed:(id)sender {
    
    if([self.regNoTextField.text length] < 6 || [self.dobTextField.text length] < 8 || [self.parentPhoneNumber.text length] < 7){
        
        if ([UIAlertController class]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Check Fields" message:@"Please make sure you've entered all the required information" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okay];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check Fields" message:@"Please make sure you've entered all the required information" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [alert show];
        }
        
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"registrationNumber"];
    [prefs removeObjectForKey:@"dateOfBirth"];
    [prefs removeObjectForKey:@"parentPhoneNumber"];
    [prefs setObject:self.regNoTextField.text forKey:@"registrationNumber"];
    [prefs setObject:self.dobTextField.text forKey:@"dateOfBirth"];
    [prefs setObject:self.parentPhoneNumber.text forKey:@"parentPhoneNumber"];
    NSLog(@"Preferences Saved");
        
    [prefs removeObjectForKey:@"firstTime_b6"];
    [prefs setObject:@"YES" forKey:@"firstTime_b6"];
    
    [self.regNoTextField resignFirstResponder];
    [self.dobTextField resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"credentialsChanged" object:nil];
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == self.dobTextField){
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(pickerChanged) forControlEvents:UIControlEventValueChanged];
        self.dobTextField.inputView = datePicker;
    }
}

-(void)pickerChanged{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ddMMYYYY"];
    self.dobTextField.text = [dateFormatter stringFromDate:[datePicker date]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)clostButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
