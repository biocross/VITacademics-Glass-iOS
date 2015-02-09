//
//  ExpanedView.h
//  VITacademics-Glass
//
//  Created by Pratham Mehta on 18/01/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedHexagonPercentageView.h"

@interface ExpanedView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
