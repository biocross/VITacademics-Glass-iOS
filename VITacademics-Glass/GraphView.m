//
//  GraphView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

- (UIBezierPath *)path
{
    if(!_path)
    {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

- (void) setBefore:(float) before
           current:(float) current
             after:(float) after
{
    _beforeValue = before;
    _currentValue = current;
    _afterValue = after;
    
    NSLog(@"Before:%f Current:%f After:%f",before,current,after);
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] setStroke];
    
    
    
    [self.path moveToPoint:CGPointMake(-rect.size.width/2, rect.size.height - self.beforeValue*rect.size.height)];
    [self.path addLineToPoint:CGPointMake(rect.size.width/2, rect.size.height - self.currentValue*rect.size.height)];
    [self.path addLineToPoint:CGPointMake(rect.size.width*3/2, rect.size.height - self.afterValue*rect.size.height)];
    
    [self.path stroke];
}


@end
