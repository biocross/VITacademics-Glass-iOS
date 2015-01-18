//
//  ExpanedView.m
//  VITacademics-Glass
//
//  Created by Pratham Mehta on 18/01/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "ExpanedView.h"

@implementation ExpanedView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        
        self.tableView = (UITableView *)[self viewWithTag:1];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
