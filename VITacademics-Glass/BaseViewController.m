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
#import <pop/POP.h>
#import <SupportKit/SupportKit.h>

#define DEBUG_MODE 1


/*
TODOs:
 
- [LOW PRIORITY] fix NSNotification center calls
- animate insertion of homeScreenCollectionView
 
*/


@interface BaseViewController (){
    BOOL coursesDragged;
    BOOL childViewsAdded;
}

@property (nonatomic) BOOL menuShowing;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (nonatomic, strong) UIPanGestureRecognizer *coursesPanGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *timeTablePangestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *coursesTapped;
@property (nonatomic, strong) UITapGestureRecognizer *timeTableTapped;
@property (strong, nonatomic) IBOutlet UIScrollView *buttonsScrollView;

@end

@implementation BaseViewController

typedef CGPoint NSPoint;


- (HomeCollectionViewController *)homeScreenCollectionViewController
{
    if(!_homeScreenCollectionViewController)
    {
        _homeScreenCollectionViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                         bundle:nil]
                                               instantiateViewControllerWithIdentifier:@"HomeCollectionViewController"];
        _homeScreenCollectionViewController.view.layer.masksToBounds = YES;
        _homeScreenCollectionViewController.view.clipsToBounds = YES;
    }
    return _homeScreenCollectionViewController;
}

- (TimeTableCollectionViewController *)timeTableCollectionViewController
{
    if(!_timeTableCollectionViewController)
    {
        _timeTableCollectionViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                         bundle:nil] instantiateViewControllerWithIdentifier:@"TimeTableCollectionViewController"];
        _timeTableCollectionViewController.view.layer.masksToBounds = YES;
        _timeTableCollectionViewController.view.clipsToBounds = YES;
    }
    return _timeTableCollectionViewController;
}

- (UIPanGestureRecognizer *)coursesPanGestureRecognizer
{
    if(!_coursesPanGestureRecognizer)
    {
        _coursesPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewDragged:)];
    }
    return _coursesPanGestureRecognizer;
}

- (UITapGestureRecognizer *)coursesTapped{
    if(!_coursesTapped){
        _coursesTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childViewTapped:)];
    }
    return _coursesTapped;
}

- (UITapGestureRecognizer *)timeTableTapped{
    if(!_timeTableTapped){
        _timeTableTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childViewTapped:)];
    }
    return _timeTableTapped;
}

- (UIPanGestureRecognizer *)timeTablePangestureRecognizer{
    if(!_timeTablePangestureRecognizer){
        _timeTablePangestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewDragged:)];
    }
    return _timeTablePangestureRecognizer;
}

-(void)childViewTapped:(UITapGestureRecognizer *)sender{
    if(sender == self.coursesTapped){
        coursesDragged = YES;
        [self hideShowCollectionViewController];
    }
    if(sender == self.timeTableTapped){
        coursesDragged = NO;
        [self hideShowCollectionViewController];
    }
}


- (void) collectionViewDragged:(UIPanGestureRecognizer *) panGestureRecognizer
{
    if(panGestureRecognizer == self.coursesPanGestureRecognizer){
        if(panGestureRecognizer.state == UIGestureRecognizerStateChanged && self.menuShowing == YES)
        {
            //Index 1
            self.homeScreenCollectionViewController.view.center = CGPointMake(self.homeScreenCollectionViewController.view.center.x,
                                                                              self.homeScreenCollectionViewController.view.center.y + [panGestureRecognizer translationInView:self.view].y);
            coursesDragged = YES;
            
            [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
        }
        else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded && self.menuShowing == YES)
        {
            [self hideShowCollectionViewController];
        }
    }
    else{
        if(panGestureRecognizer.state == UIGestureRecognizerStateChanged && self.menuShowing == YES)
        {
            //Index 2
            self.timeTableCollectionViewController.view.center = CGPointMake(self.timeTableCollectionViewController.view.center.x,
                                                                             self.timeTableCollectionViewController.view.center.y + [panGestureRecognizer translationInView:self.view].y);
            
            coursesDragged = NO;
            [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
        }
        else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded && self.menuShowing == YES)
        {
            [self hideShowCollectionViewController];
        }
    }
    
}

- (IBAction)campusMapPressed:(id)sender {
    CampusMapViewController *mapController = [self.storyboard instantiateViewControllerWithIdentifier:@"campusMap"];
    [self presentViewController:mapController animated:YES completion:nil];
    
}

-(void)showInfoToUserWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    if ([UIAlertController class]) {
        UIAlertController *error = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [error addAction:okay];
        
        [self presentViewController:error animated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
    
    
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime_b8"])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"registrationNumber"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"dateOfBirth"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"campus"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"parentPhoneNumber"];
        
        [self performSelector:(@selector(beginLoginProcess)) withObject:nil afterDelay:1];
    }
    else{
        [self addChildViews];
    }

    [self.view bringSubviewToFront:self.shimmeringView];
    
    [VITXManager sharedManager].baseViewController = self;
    [self hideLoadingIndicator];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.shimmeringView.bounds];
    loadingLabel.text = @"Loading...";
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.shimmeringView.contentView = loadingLabel;
    self.shimmeringView.shimmering = YES;
    
    childViewsAdded = NO;
    coursesDragged = YES; //Default View is Courses View.
}

-(void)showLoadingIndicator{
    self.shimmeringView.hidden = NO;
}

-(void)hideLoadingIndicator{
    self.shimmeringView.hidden = YES;
}

-(void)addTimeTableView
{
    [self addChildViewController:self.timeTableCollectionViewController];
    [self.view insertSubview:self.timeTableCollectionViewController.view atIndex:2];
    [self addshadows:self.timeTableCollectionViewController.view];
    [self.view sendSubviewToBack:self.buttonsScrollView];
    //self.menuButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.15];
    [self.timeTableCollectionViewController.view addGestureRecognizer:self.timeTablePangestureRecognizer];
}

-(void)addCollectionView
{
    [self addChildViewController:self.homeScreenCollectionViewController];
    [self.view insertSubview:self.homeScreenCollectionViewController.view atIndex:1];
    [self addshadows:self.homeScreenCollectionViewController.view];
    [self.view sendSubviewToBack:self.buttonsScrollView];
    [self.homeScreenCollectionViewController.view addGestureRecognizer:self.coursesPanGestureRecognizer];
}

- (void)addChildViews{
    //[self addCollectionView];
    [self addTimeTableView];
    
    [self.view bringSubviewToFront:self.menuButton];
    
    childViewsAdded = YES;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for(UIButton *button in self.MenuButtons){
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    }

    [self.homeScreenCollectionViewController.view addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGPoint new = [change[@"new"] CGPointValue];
#warning Hardcoded Values
    float alpha = (new.y - 284) / 384;
    self.buttonsScrollView.alpha = alpha;
}

-(void)dealloc{
    [self.homeScreenCollectionViewController removeObserver:self forKeyPath:@"view.center.y" context:nil];
}

-(void)beginLoginProcess
{
    LoginViewController *loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginViewController animated:YES completion:^{
        [self addChildViews];
    }];
}


- (void) addshadows:(UIView *)view
{
    view.layer.shadowRadius = 10.0;
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeZero;
}

- (IBAction)menuButtonTapped:(id)sender
{
    [self hideShowCollectionViewController];
}

- (void) hideShowCollectionViewController
{
    if(self.menuShowing)
    {
        
        if(coursesDragged){
            POPSpringAnimation *masterUp1 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            masterUp1.toValue = [NSValue valueWithCGPoint:self.view.center];
            masterUp1.springBounciness = 7;
            [self.homeScreenCollectionViewController.view pop_addAnimation:masterUp1 forKey:@"up1"];
            
            POPSpringAnimation *slaveDown1 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            slaveDown1.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + self.view.bounds.size.height)];
            slaveDown1.springBounciness = 4;
            [self.timeTableCollectionViewController.view pop_addAnimation:slaveDown1 forKey:@"down1"];
            
        }
        else {
            POPSpringAnimation *upAnimation2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            upAnimation2.toValue = [NSValue valueWithCGPoint:self.view.center];
            upAnimation2.springBounciness = 7;
            [self.timeTableCollectionViewController.view pop_addAnimation:upAnimation2 forKey:@"up2"];
            
            POPSpringAnimation *slaveDown1 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            slaveDown1.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + self.view.bounds.size.height)];
            slaveDown1.springBounciness = 4;
            [self.homeScreenCollectionViewController.view pop_addAnimation:slaveDown1 forKey:@"down2"];
        }
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.collectionView.userInteractionEnabled = YES;
                             self.timeTableCollectionViewController.collectionView.userInteractionEnabled = YES;
                             self.homeScreenCollectionViewController.view.layer.cornerRadius = 0;
                             self.timeTableCollectionViewController.view.layer.cornerRadius = 0;
                         }];
        self.menuShowing = NO;
        [self.homeScreenCollectionViewController.view removeGestureRecognizer:self.coursesTapped];
        [self.timeTableCollectionViewController.view removeGestureRecognizer:self.timeTableTapped];
        
    }
    else
    {
            POPSpringAnimation *coursesAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            coursesAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, ((self.view.bounds.size.height) + 100))];
            coursesAnimation.springBounciness = 8;
            [self.homeScreenCollectionViewController.view pop_addAnimation:coursesAnimation forKey:@"down1"];
            
            POPSpringAnimation *timeTableAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            timeTableAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, ((self.view.bounds.size.height) + 200))];
            timeTableAnimation.springBounciness = 8;
            [self.timeTableCollectionViewController.view pop_addAnimation:timeTableAnimation forKey:@"down1"];
            
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 self.homeScreenCollectionViewController.collectionView.userInteractionEnabled = NO;
                                 self.timeTableCollectionViewController.collectionView.userInteractionEnabled = NO;
                                 self.homeScreenCollectionViewController.view.layer.cornerRadius = 10;
                                 self.timeTableCollectionViewController.view.layer.cornerRadius = 10;
                             }];
        
        self.menuShowing = YES;
        [self.homeScreenCollectionViewController.view addGestureRecognizer:self.coursesTapped];
        [self.timeTableCollectionViewController.view addGestureRecognizer:self.timeTableTapped];
    }

}

- (IBAction)coursesPressed:(id)sender {
    coursesDragged = YES;
    [self hideShowCollectionViewController];
}

- (IBAction)refreshedPressed:(id)sender {
    [self showLoadingIndicator];
    dispatch_queue_t downloadQueue = dispatch_queue_create("serverStatus", nil);
    dispatch_async(downloadQueue, ^{
        
        NSString *buildingUrl;
        if(DEBUG_MODE){
            buildingUrl = @"http://localhost:8003";
        }
        else{
            buildingUrl = [NSString stringWithFormat:@"https://vitacademics-rel.herokuapp.com/api/v2/system"];
        }
        NSURL *url = [NSURL URLWithString:buildingUrl];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        NSError * error = nil;
        NSURLResponse * response = nil;
        
        [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        int httpCode = (int)[(NSHTTPURLResponse *)response statusCode];
        int shouldLoadAttendance = httpCode;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Status: %d", shouldLoadAttendance);
            
            [self hideLoadingIndicator];
            
            if(!shouldLoadAttendance){
                [self showInfoToUserWithTitle:@"Network Error" andMessage:@"Are you connected to the internet?"];
            }
            else if(shouldLoadAttendance == 200){
                [[VITXManager sharedManager] startRefreshing];
            }
            else{
                [self showInfoToUserWithTitle:@"Server Error" andMessage:@"Please try again a little bit later"];
            }
            
        });//end of GCD
    });
    
}



- (IBAction)credentialsPressed:(id)sender {
    [self beginLoginProcess];
}

- (IBAction)feedbackPressed:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [[SKTUser currentUser] addProperties:@{ @"regno" : [prefs stringForKey:@"registrationNumber"], @"dob" : [prefs stringForKey:@"dateOfBirth"], @"phoneNumber" : [prefs stringForKey:@"parentPhoneNumber"] }];
    [SupportKit show];
    
}

/*- (IBAction)timeTablePressed:(id)sender {
//    coursesDragged = NO;
//    [self hideShowCollectionViewController];
    
    [self showInfoToUserWithTitle:@"Coming Soon" andMessage:@"We're working on this. Please hang on."];
}*/

@end
