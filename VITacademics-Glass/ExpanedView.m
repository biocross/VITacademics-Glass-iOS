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
        self.hexagonView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    return self;
}


@end
