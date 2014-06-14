//
//  SAProgressBarView.h
//  progress
//
//  Created by Shimpei Azuma  on 2013/12/14.
//  Copyright (c) 2013年 Shimpei Azuma . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAProgressBarFill.h"

@interface SAProgressBarView : UIView {
    
    UIColor* color;
    SAProgressBarFill* fill;
}

- (void)backgroundColor:(UIColor*)col;
- (void)fillColor:(UIColor*)col;
- (void)setProgress:(float)progress;
- (void)risingAnimationWithDuration:(float)duration startProgress:(float)stprog endProgress:(float)endprog loops:(NSInteger)loops maxDelegate:(id)maxD maxSelector:(SEL)maxS completeDelegate:(id)compD completeSelector:(SEL)compS;

@end
