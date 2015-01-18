//
//  TodayView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/17/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TodayView.h"

@implementation TodayView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        
        self.tableView = (UITableView *)[self viewWithTag:1];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return self;
}



- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.backgroundColor = [UIColor clearColor];
    
    if(indexPath.row%2 == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:0
                                               green:0
                                                blue:0
                                               alpha:0.2];
    }
    
    return cell;
}

@end
