//
//  GraphView.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/16/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "GraphView.h"
#import "DateTools.h"

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

- (UIBezierPath *)pointerPath
{
    if(!_pointerPath)
    {
        _pointerPath = [UIBezierPath bezierPath];
    }
    return _pointerPath;
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
    [self.tintColor setStroke];
    [self.tintColor setFill];

    [self.graphLinePath moveToPoint:CGPointMake(-rect.size.width/2, (rect.size.height*0.8 - self.beforeValue*rect.size.height*0.8)+0.1*rect.size.height)];
    [self.graphLinePath addLineToPoint:CGPointMake(rect.size.width/2, (rect.size.height*0.8 - self.currentValue*rect.size.height*0.8)+0.1*rect.size.height)];
    [self.graphLinePath addLineToPoint:CGPointMake(rect.size.width*3/2, (rect.size.height*0.8 - self.afterValue*rect.size.height*0.8)+0.1*rect.size.height)];
    [self.graphLinePath setLineWidth:2.5];
    [self.graphLinePath stroke];
    
    
    
    [self.pointerPath moveToPoint:CGPointMake(rect.size.width/2,
                                              (rect.size.height*0.8 - self.currentValue*rect.size.height*0.8)+0.1*rect.size.height)];
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    
    NSString *string;
    if(self.lastUpdated){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"EEEE, MMM dd"];
        NSString *dateString = [format stringFromDate:self.lastUpdated];
        string = [@"Updated: " stringByAppendingString:dateString];
    }
    else{
        string = @"Not Uploaded";
    }
    
    
    
    if(self.currentValue<0.5)
    {
        [self.pointerPath addLineToPoint:CGPointMake(rect.size.width/2,
                                                     30)];
        
        self.updateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, rect.size.width, 20)];
        self.updateLabel.text = string;
        self.updateLabel.textColor = self.tintColor;
        self.updateLabel.textAlignment = NSTextAlignmentCenter;
        self.updateLabel.font = [UIFont systemFontOfSize:10];
        
    }
    else
    {
        [self.pointerPath addLineToPoint:CGPointMake(rect.size.width/2,
                                                     rect.size.height-30)];
        
        self.updateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height-30, rect.size.width, 20)];
        self.updateLabel.text = string;

        self.updateLabel.numberOfLines = 2;

        self.updateLabel.textColor = self.tintColor;
        self.updateLabel.textAlignment = NSTextAlignmentCenter;
        self.updateLabel.font = [UIFont systemFontOfSize:10];
    }
    [self addSubview:self.updateLabel];
    [[UIColor lightGrayColor] setStroke];
    
    
    CGFloat bezier2Pattern[] = {2, 2, 2, 2};
    [self.pointerPath setLineDash:bezier2Pattern count: 4 phase: 0];
    [[UIColor lightGrayColor] setStroke];
    [self.pointerPath stroke];
    
    self.circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/2-5,
                                                                        (rect.size.height*0.8 - self.currentValue*rect.size.height*0.8-5)+0.1*rect.size.height,
                                                                        10,
                                                                        10)];
    [self.tintColor setStroke];
    [self.circlePath stroke];
    [self.circlePath fill];
    

    
}


@end
