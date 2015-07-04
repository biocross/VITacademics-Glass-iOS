//
//  TimeTableDayView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 2/7/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "TimeTableDayView.h"
#import "Courses.h"

@implementation TimeTableDayView


- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        
    }
    return self;
}

- (void) reloadEverything{
    self.timeTableForDay = [self.timeTableForDay sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"start" ascending:YES]]];
    [self.tableView reloadData];
}

- (void) setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.timeTableForDay count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh:mm a"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:19800];
    NSString *startTime = [df stringFromDate:self.timeTableForDay[section][@"start"]];
    NSString *endTime = [df stringFromDate:self.timeTableForDay[section][@"end"]];
    
    return [NSString stringWithFormat:@"%@ to %@", startTime, endTime];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(5, 23, 130, 12);
    if(section == 0){
        myLabel.frame = CGRectMake(5, 41, 130, 12);
    }
    myLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    myLabel.textColor = [UIColor lightGrayColor];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Courses *course = self.timeTableForDay[indexPath.section][@"course"];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TimeTableCell" owner:self options:nil];
    UITableViewCell *cell  = [views firstObject];
    
    UILabel *subjectName = (UILabel *)[cell viewWithTag:1];
    UILabel *subjectTime = (UILabel *)[cell viewWithTag:2];
    UILabel *subjectVenue = (UILabel *)[cell viewWithTag:3];
    
    subjectName.text = course.course_title;
    subjectVenue.text = course.venue;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh:mm a"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:19800];
    NSString *startTime = [df stringFromDate:self.timeTableForDay[indexPath.row][@"start"]];
    NSString *endTime = [df stringFromDate:self.timeTableForDay[indexPath.row][@"end"]];
    
    subjectTime.text = [NSString stringWithFormat:@"%@ to %@", startTime, endTime];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}



@end
