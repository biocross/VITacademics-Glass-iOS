//
//  BaseViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@property (nonatomic) BOOL menuShowing;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation BaseViewController

- (HomeCollectionViewController *)homeScreenCollectionViewController
{
    if(!_homeScreenCollectionViewController)
    {
        _homeScreenCollectionViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                         bundle:nil] instantiateViewControllerWithIdentifier:@"HomeCollectionViewController"];
    }
    return _homeScreenCollectionViewController;
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime"]){
        [self performSelector:(@selector(beginLoginProcess)) withObject:nil afterDelay:1];
    }
    else{
        [self addChildViewController:self.homeScreenCollectionViewController];
        [self.view insertSubview:self.homeScreenCollectionViewController.view belowSubview:self.menuButton];
        
        [self addshadows];
    }
    
    [self.view sendSubviewToBack:self.buttonsView];
    self.menuButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.25];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for(UIButton *button in self.MenuButtons){
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    }

}

-(void)beginLoginProcess
{
    
    LoginViewController *loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self presentViewController:loginViewController animated:YES completion:nil];
}


- (void) addshadows
{
    self.homeScreenCollectionViewController.view.layer.shadowRadius = 10.0;
    self.homeScreenCollectionViewController.view.layer.shadowOpacity = 0.8;
    self.homeScreenCollectionViewController.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.homeScreenCollectionViewController.view.layer.shadowOffset = CGSizeZero;
}

- (IBAction)menuButtonTapped:(id)sender
{
    if(self.menuShowing)
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.view.transform = CGAffineTransformIdentity;
                             self.homeScreenCollectionViewController.view.layer.cornerRadius = 0;
                             self.homeScreenCollectionViewController.view.userInteractionEnabled = YES;
                         }];
        self.menuShowing = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.view.transform = CGAffineTransformMakeTranslation(0, 400);
                             self.homeScreenCollectionViewController.view.userInteractionEnabled = NO;
                         }];
        self.menuShowing = YES;
    }
}

@end
