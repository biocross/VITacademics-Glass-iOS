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
    
    
    //int percentage = self.currentValue * 100;
    
    [[UIColor yellowColor] setStroke];
    
    
    
    
    
    [self.path moveToPoint:CGPointMake(-rect.size.width/2, rect.size.height - self.beforeValue*rect.size.height)];
    [self.path addLineToPoint:CGPointMake(rect.size.width/2, rect.size.height - self.currentValue*rect.size.height)];
    [self.path addLineToPoint:CGPointMake(rect.size.width*3/2, rect.size.height - self.afterValue*rect.size.height)];
    [self.path setLineWidth:2.5];
    [self.path stroke];
    
    
    /*MultiplePulsingHaloLayer *halo = [[MultiplePulsingHaloLayer alloc] initWithHaloLayerNum:3 andStartInterval:0.7];
    
    [halo buildSublayers];
    
    PulsingHaloLayer *halo = [PulsingHaloLayer layer];
    
    halo.position = CGPointMake(rect.size.width/2, rect.size.height - self.currentValue*rect.size.height);
    halo.radius = rect.size.width/2;
    
    
    
    
    halo.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:halo];
    
    if(percentage > 74){
        halo.radius = 20;
        halo.backgroundColor = [UIColor colorWithRed:0.2
                                               green:0.2
                                                blue:0.9
                                               alpha:1.0].CGColor;
    }*/
}


@end
