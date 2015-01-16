//
//  RoundedHexagonPercentageView.m
//  VITacademics-Glass
//
//  Created by Pratham Mehta on 16/01/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "RoundedHexagonPercentageView.h"

@implementation RoundedHexagonPercentageView

- (UIBezierPath *)roundedPolygonPathWithRect:(CGRect)square
                                   lineWidth:(CGFloat)lineWidth
                                       sides:(NSInteger)sides
                                cornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *path  = [UIBezierPath bezierPath];
    
    CGFloat theta       = 2.0 * M_PI / sides;                           // how much to turn at every corner
    CGFloat offset      = cornerRadius * tanf(theta / 2.0);             // offset from which to start rounding corners
    CGFloat squareWidth = MIN(square.size.width, square.size.height);   // width of the square
    
    // calculate the length of the sides of the polygon
    
    CGFloat length      = squareWidth - lineWidth;
    if (sides % 4 != 0) {                                               // if not dealing with polygon which will be square with all sides ...
        length = length * cosf(theta / 2.0) + offset/2.0;               // ... offset it inside a circle inside the square
    }
    CGFloat sideLength = length * tanf(theta / 2.0);
    
    // start drawing at `point` in lower right corner
    
    CGPoint point = CGPointMake(squareWidth / 2.0 + sideLength / 2.0 - offset, squareWidth - (squareWidth - length) / 2.0);
    CGFloat angle = M_PI;
    [path moveToPoint:point];
    
    // draw the sides and rounded corners of the polygon
    
    for (NSInteger side = 0; side < sides; side++) {
        point = CGPointMake(point.x + (sideLength - offset * 2.0) * cosf(angle), point.y + (sideLength - offset * 2.0) * sinf(angle));
        [path addLineToPoint:point];
        
        CGPoint center = CGPointMake(point.x + cornerRadius * cosf(angle + M_PI_2), point.y + cornerRadius * sinf(angle + M_PI_2));
        [path addArcWithCenter:center radius:cornerRadius startAngle:angle - M_PI_2 endAngle:angle + theta - M_PI_2 clockwise:YES];
        
        point = path.currentPoint; // we don't have to calculate where the arc ended ... UIBezierPath did that for us
        angle += theta;
    }
    
    [path closePath];
    
    return path;
}

- (UILabel *)percentageLabel
{
    if(!_percentageLabel)
    {
        _percentageLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _percentageLabel.font = [UIFont systemFontOfSize:25];
        _percentageLabel.textColor = [UIColor whiteColor];
        _percentageLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _percentageLabel;
}

- (void)setPercentage:(float)percentage
{
    _percentage = percentage;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    self.hexagonPath = [self roundedPolygonPathWithRect:rect
                                              lineWidth:10
                                                  sides:6
                                           cornerRadius:10];
    self.hexagonPath.lineWidth = 2.0;
    [[UIColor darkGrayColor] setStroke];
    [self.hexagonPath stroke];
    CAShapeLayer *halfBezier = [CAShapeLayer layer];
    halfBezier.path          = [self.hexagonPath CGPath];
    halfBezier.fillColor     = [[UIColor clearColor] CGColor];
    halfBezier.strokeColor   = [[UIColor whiteColor] CGColor];
    halfBezier.lineWidth     = 3.0;
    [self.layer addSublayer:halfBezier];
    halfBezier.strokeEnd = self.percentage/100;
    
    self.percentageLabel.text = [NSString stringWithFormat:@"%1.0f",self.percentage];
    self.percentageLabel.transform = CGAffineTransformMakeRotation(-M_PI/6+M_PI);
    [self addSubview:self.percentageLabel];
}


@end
