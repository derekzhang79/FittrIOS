//
//  DrawingView.m
//  Fittr
//
//  Created by So Townsend on 12/15/12.
//  Copyright (c) 2012 GndFloor. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Hi");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 3.0f);
    [[UIColor redColor] setStroke];
    
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, self.bounds.origin.x + 20, self.bounds.origin.y + 20, 8.0f, 0.0f, 3.141592654f*2.0f, 1);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

@end
