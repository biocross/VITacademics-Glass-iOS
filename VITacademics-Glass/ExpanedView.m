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
    if ((self = [super initWithCoder:aDecoder])) {}
    return self;
}

- (void) setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if(indexPath.row%2 == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];
    }

    return cell;
}




@end
