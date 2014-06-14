//
//  SAProgressBarFill.m
//  progress
//
//  Created by Shimpei Azuma  on 2013/12/14.
//  Copyright (c) 2013年 Shimpei Azuma . All rights reserved.
//

#import "SAProgressBarFill.h"

@implementation SAProgressBarFill

- (id)initWithFrame:(CGRect)frame padding:(CGSize)padding
{
    float x = padding.width;
    float y = padding.height;
    float w = frame.size.width - (padding.width * 2);
    float h = frame.size.height - (padding.height * 2);
    fixedFrame = CGRectMake(x, y, w, h);
    self = [super initWithFrame:CGRectMake(x, y, w, h)];
    if (self) {
        // Initialization code
        [self initWorks];
        self.contentMode = UIViewContentModeTopLeft;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        color = [UIColor blackColor];
    }
    return self;
}

- (void)setProgress:(float)progress {
    if (progress > 1.0f) progress = 1.0f;
    if (progress < 0.0f) progress = 0.0f;
    self.frame = [self frameInfluenceByProgress:progress];
}
- (CGRect)frameInfluenceByProgress:(float)progress {
    float width = fixedFrame.size.width * progress;
    return CGRectMake(fixedFrame.origin.x, fixedFrame.origin.y, width, fixedFrame.size.height);
}

- (void)setFillColor:(UIColor*)col {
    color = col;
    CGRect frame = self.frame;
    self.frame = fixedFrame;
    [self setNeedsDisplay];
    self.frame = frame;
}

- (void)initWorks {
    loopCounter = 0;
    loopCounterMax = 0;
    startProgress = 0;
    endProgress = 0;
    maxDelegate = NULL;
    maxSelector = NULL;
    completeDelegate = NULL;
    completeSelector = NULL;
    durationList = nil;
}

- (void)risingAnimationWithDuration:(float)duration startProgress:(float)stprog endProgress:(float)endprog loops:(NSInteger)loops maxDelegate:(id)maxD maxSelector:(SEL)maxS completeDelegate:(id)compD completeSelector:(SEL)compS {

    loopCounter = 0;
    loopCounterMax = loops;
    startProgress = stprog;
    endProgress = endprog;
    maxDelegate = maxD;
    maxSelector = maxS;
    completeDelegate = compD;
    completeSelector = compS;
    durationList = nil;
    durationList = [NSMutableArray array];
    
    float gaugeLength = [self getGaugeLength:loopCounterMax startProgress:startProgress endProgress:endProgress];

    float primitiveTime = duration / gaugeLength;
    for (int i=0;i<=loopCounterMax;i++) {
        switch (loopCounterMax) {
            case 0:
                [durationList addObject:[NSNumber numberWithFloat:primitiveTime * (endProgress - startProgress)]];
                break;
            default:
                if (i == 0) {
                    [durationList addObject:[NSNumber numberWithFloat:primitiveTime * (1.0 - startProgress)]];
                }
                else if (i == loopCounterMax) {
                    [durationList addObject:[NSNumber numberWithFloat:primitiveTime * (endProgress)]];
                }
                else {
                    [durationList addObject:[NSNumber numberWithFloat:primitiveTime * (1.0f)]];
                }
                break;
        }
    }
    [self risingAnimation];
}

- (void)risingAnimation {
    if (loopCounter != 0) {
        self.frame = [self frameInfluenceByProgress:0.0f];
    }
    else {
        self.frame = [self frameInfluenceByProgress:startProgress];
    }
    //UIViewAnimationOptionAllowAnimatedContent
    
    
    [UIView animateWithDuration: [[durationList objectAtIndex:loopCounter] floatValue]
                          delay:0.0f
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^(void) {
                        if (loopCounter != loopCounterMax) {
                            self.frame = [self frameInfluenceByProgress:1.0f];
                        }
                        else {
                            self.frame = [self frameInfluenceByProgress:endProgress];
                        }
                     }
                     completion:^(BOOL finished) {
                        if (loopCounter != loopCounterMax) {
                            [self delegatePerformSelector:maxDelegate selector:maxSelector withObject:nil];
                            loopCounter++;
                            [self risingAnimation];
                        }
                        else {
                            [self delegatePerformSelector:completeDelegate selector:completeSelector withObject:nil];
                            [self initWorks];
                        }
                    }
    ];
    
}


- (float)getGaugeLength:(NSInteger)loops startProgress:(float)stprog endProgress:(float)endprog{
    float gaugeLength = 0.0f;
    switch (loops) {
        case 0:
            gaugeLength = endprog - stprog;
            break;
        case 1:
            gaugeLength = 1.0 - stprog + endprog;
            break;
        default:
            gaugeLength = 1.0 - stprog + endprog;
            gaugeLength += 1.0 * (float)(loops - 1);
            break;
    }
    return gaugeLength;
}


- (void)delegatePerformSelector:(id)obj selector:(SEL)sel withObject:(id)wObj {
    if (sel != NULL) {
        if ([obj respondsToSelector:sel]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:sel withObject:wObj];
            #pragma clang diagnostic pop
        }
    }
}

- (void)drawProgressBar
{
    CGSize size = fixedFrame.size;
    CGFloat unit = size.height/2.0;
    CGRect barRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:barRect cornerRadius:unit];
    [path fill];
}
- (void)drawRect:(CGRect)rect
{
    [color setFill];
    [self drawProgressBar];
}


@end
