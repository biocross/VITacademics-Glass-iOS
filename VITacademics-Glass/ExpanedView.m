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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 224;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 70;
            break;
        case 3:
            return 80;
            break;
        case 4:
            return 90;
            break;
            
        default:
            break;
    }
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
    
    for(UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }
    
    UIView *viewToBeAdded;
    
    switch(indexPath.row)
    {
            case 0:
            viewToBeAdded = [[NSBundle mainBundle] loadNibNamed:@"TopAttendanceView" owner:self options:nil].firstObject;
            viewToBeAdded.frame = CGRectMake(0, 0, cell.bounds.size.width, 224);
            [cell.contentView addSubview:viewToBeAdded];
            break;
    }
    
    cell.contentView.clipsToBounds = YES;
    cell.contentView.layer.masksToBounds = YES;

    return cell;
}




@end
