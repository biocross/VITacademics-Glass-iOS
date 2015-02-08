//
//  TimeTableDayView.h
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 2/7/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableDayView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;

@end
