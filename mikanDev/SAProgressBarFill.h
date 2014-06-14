//
//  SAProgressBarFill.h
//  progress
//
//  Created by Shimpei Azuma  on 2013/12/14.
//  Copyright (c) 2013年 Shimpei Azuma . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAProgressBarFill : UIView {
    
    CGRect fixedFrame;
    UIColor* color;
    
    
    NSInteger loopCounter;
    NSInteger loopCounterMax;
    id  maxDelegate;
    SEL maxSelector;
    id  completeDelegate;
    SEL completeSelector;
    float startProgress;
    float endProgress;
    NSMutableArray* durationList;
    
    
}

- (id)initWithFrame:(CGRect)frame padding:(CGSize)padding ;
- (void)setProgress:(float)progress ;
- (void)setFillColor:(UIColor*)col;
- (void)risingAnimationWithDuration:(float)duration startProgress:(float)stprog endProgress:(float)endprog loops:(NSInteger)loops maxDelegate:(id)maxD maxSelector:(SEL)maxS completeDelegate:(id)compD completeSelector:(SEL)compS;

@end
