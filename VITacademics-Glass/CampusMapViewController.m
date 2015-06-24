//
//  CampusMapViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 6/24/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "CampusMapViewController.h"

@interface CampusMapViewController ()
@end

@implementation CampusMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Campus Map";
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vitmap.jpg"]];
    
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 5;
    self.scrollView.zoomScale = 0.4;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view bringSubviewToFront:self.closeButton];
    
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
