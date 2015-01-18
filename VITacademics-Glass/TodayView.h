//
//  TodayView.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/17/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
