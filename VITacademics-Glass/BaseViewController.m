//
//  BaseViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "VITXManager.h"


/*
TODOs:
 
- [LOW PRIORITY] fix NSNotification center calls
- animate insertion of homeScreenCollectionView
- loading indicator / clue / something!
 
*/


@interface BaseViewController ()

@property (nonatomic) BOOL menuShowing;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

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

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if(!_panGestureRecognizer)
    {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewDragged:)];
    }
    return _panGestureRecognizer;
}

- (void) collectionViewDragged:(UIPanGestureRecognizer *) panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateChanged && self.menuShowing == YES)
    {
        self.homeScreenCollectionViewController.view.center = CGPointMake(self.homeScreenCollectionViewController.view.center.x,
                                                                          self.homeScreenCollectionViewController.view.center.y + [panGestureRecognizer translationInView:self.view].y);
        [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded && self.menuShowing == YES)
    {
        [self hideShowCollectionViewController];
    }
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime"]){
        [self performSelector:(@selector(beginLoginProcess)) withObject:nil afterDelay:1];
    }
    else{
        [self addCollectionView];
    }

    [self.view bringSubviewToFront:self.loadingIndicator];
    
#warning shit
[VITXManager sharedManager].baseViewController = self;
    [self hideLoadingIndicator];
    
}


-(void)showLoadingIndicator{
    self.loadingIndicator.hidden = NO;
}

-(void)hideLoadingIndicator{
    self.loadingIndicator.hidden = YES;
}

-(void)addCollectionView
{
    
    [self addChildViewController:self.homeScreenCollectionViewController];
    [self.view insertSubview:self.homeScreenCollectionViewController.view belowSubview:self.menuButton];
    [self addshadows];
    [self.view sendSubviewToBack:self.buttonsView];
    self.menuButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.15];
    [self.homeScreenCollectionViewController.view addGestureRecognizer:self.panGestureRecognizer];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for(UIButton *button in self.MenuButtons){
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    }

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(addCollectionView)
     name:@"prepareViewsForDataPresentation"
     object:nil];
    
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
    [self hideShowCollectionViewController];
}

- (void) hideShowCollectionViewController
{
    if(self.menuShowing)
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.view.center = self.view.center;
                             self.homeScreenCollectionViewController.collectionView.userInteractionEnabled = YES;
                         }];
        self.menuShowing = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.view.center = CGPointMake(self.view.center.x, self.homeScreenCollectionViewController.view.center.y + 400);
                             self.homeScreenCollectionViewController.collectionView.userInteractionEnabled = NO;
                         }];
        self.menuShowing = YES;
    }

}

- (IBAction)coursesPressed:(id)sender {
}

- (IBAction)timeTablePressed:(id)sender {
    [[VITXManager sharedManager] startRefreshing];
}

- (IBAction)credentialsPressed:(id)sender {
    [self beginLoginProcess];
}

- (IBAction)feedbackPressed:(id)sender {
    
}
- (IBAction)aboutPressed:(id)sender {
}
@end
