//
//  CGPATableViewController.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 4/3/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VITXManager.h"
#import "CCColorCube.h"
#import "GradesRoot.h"
#import "GradedCourseObject.h"

@interface CGPATableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *currentCGPA;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *expectedCGPA;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *expectedCGPALabel;
@property (strong, nonatomic) IBOutlet UIToolbar *currentToolbar;
@property (strong, nonatomic) IBOutlet UIToolbar *expectedToolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *currentCGPALabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *resetButton;

- (IBAction)closePressed:(id)sender;
- (IBAction)resetPressed:(id)sender;


@end
