//
//  SAProgressBarView.m
//  progress
//
//  Created by Shimpei Azuma  on 2013/12/14.
//  Copyright (c) 2013年 Shimpei Azuma . All rights reserved.
//

#import "SAProgressBarView.h"

@implementation SAProgressBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        color = [UIColor redColor];
        frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGSize pad = CGSizeMake(1.0f, 1.0f);
        fill = [[SAProgressBarFill alloc] initWithFrame:frame padding:pad];
        [fill setProgress:1.0f];
        [self addSubview:fill];
        
    }
    return self;
}

- (void)backgroundColor:(UIColor*)col {
    color = col;
    [self setNeedsDisplay];
}
- (void)fillColor:(UIColor*)col {
    [fill setFillColor:col];
}
- (void)setProgress:(float)progress {
    [fill setProgress:progress];
}
- (void)risingAnimationWithDuration:(float)duration startProgress:(float)stprog endProgress:(float)endprog loops:(NSInteger)loops maxDelegate:(id)maxD maxSelector:(SEL)maxS completeDelegate:(id)compD completeSelector:(SEL)compS {
    
    [fill risingAnimationWithDuration:duration startProgress:stprog endProgress:endprog loops:loops maxDelegate:maxD maxSelector:maxS completeDelegate:compD completeSelector:compS];
    
}

- (void)drawBackgroundBar
{
    
    CGSize size = self.frame.size;
    CGFloat unit = size.height/2.0;
    
    CGRect barRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:barRect cornerRadius:unit];
    [path fill];
    
}

- (void)drawRect:(CGRect)rect
{
    [color setFill];
    [self drawBackgroundBar];
}
@end
