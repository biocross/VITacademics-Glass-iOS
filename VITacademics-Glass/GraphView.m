//
//  GraphView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "GraphView.h"
#import "MultiplePulsingHaloLayer.h"
#import "PulsingHaloLayer.h"

@implementation GraphView

- (UIBezierPath *)graphLinePath
{
    if(!_graphLinePath)
    {
        _graphLinePath = [UIBezierPath bezierPath];
    }
    return _graphLinePath;
}

- (UIBezierPath *)circlePath
{
    if(!_circlePath)
    {
        _circlePath = [UIBezierPath bezierPath];
    }
    return _circlePath;
}

- (void) setBefore:(float) before
           current:(float) current
             after:(float) after
{
    _beforeValue = before;
    _currentValue = current;
    _afterValue = after;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];

    [self.graphLinePath moveToPoint:CGPointMake(-rect.size.width/2, (rect.size.height*0.8 - self.beforeValue*rect.size.height*0.8)+0.1*rect.size.height)];
    [self.graphLinePath addLineToPoint:CGPointMake(rect.size.width/2, (rect.size.height*0.8 - self.currentValue*rect.size.height*0.8)+0.1*rect.size.height)];
    [self.graphLinePath addLineToPoint:CGPointMake(rect.size.width*3/2, (rect.size.height*0.8 - self.afterValue*rect.size.height*0.8)+0.1*rect.size.height)];
    [self.graphLinePath setLineWidth:2.5];
    [self.graphLinePath stroke];
    
    self.circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/2-5,
                                                                        (rect.size.height*0.8 - self.currentValue*rect.size.height*0.8-5)+0.1*rect.size.height,
                                                                        10,
                                                                        10)];
    [self.circlePath stroke];
    [self.circlePath fill];
    
    
    
    }


@end
