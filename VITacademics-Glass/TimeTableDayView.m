//
//  TimeTableDayView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 2/7/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TimeTableDayView.h"

@implementation TimeTableDayView


- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
    }
    return self;
}

- (void) setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TimeTableCell" owner:self options:nil];
    UITableViewCell *cell  = [views firstObject];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}



@end
