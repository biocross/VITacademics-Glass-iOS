//
//  CampusMapViewController.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/24/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusMapViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)closeButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@end
