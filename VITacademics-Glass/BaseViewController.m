//
//  BaseViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "BaseViewController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewController:self.homeScreenCollectionViewController];
    [self.view insertSubview:self.homeScreenCollectionViewController.view belowSubview:self.menuButton];
    
    [self addshadows];
}

- (void) addshadows
{
    self.homeScreenCollectionViewController.view.layer.shadowRadius = 5.0;
    self.homeScreenCollectionViewController.view.layer.shadowOpacity = 0.8;
    self.homeScreenCollectionViewController.view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
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
                         }];
        self.menuShowing = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.view.transform = CGAffineTransformMakeTranslation(0, 400);
                         }];
        self.menuShowing = YES;
    }
}

@end
