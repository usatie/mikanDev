//
//  GGDraggableView.m
//  TinderLikeAnimations2
//
//  Created by Shun Usami on 2014/05/21.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "GGDraggableView.h"

@interface GGDraggableView ()
//@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
//@property (nonatomic) CGPoint originalPoint;
//@property (nonatomic, strong) GGOverlayView *overlayView;
//@property int i;
@end



@implementation GGDraggableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self loadImageAndStyle];

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    
    self.overlayView = [[GGOverlayView alloc] initWithFrame:self.bounds];
    self.overlayView.alpha = 0;
    [self addSubview:self.overlayView];
    
    return self;
}

- (void)loadImageAndStyle
{
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar"]];
    //[self addSubview:imageView];
    self.backgroundColor = [UIColor whiteColor];
        
    self.layer.cornerRadius = 8;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.5;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(japaneseDisplayIfTouched)]) {
        [_delegate japaneseDisplayIfTouched];
    } else {NSLog(@"no responds to japaneseDisplayIfTouched");}
}

- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGFloat rotationStrength = MIN(xDistance/320, 1);
            CGFloat rotationAngle = (CGFloat) (2*M_PI/16 * rotationStrength);
            CGFloat scaleStrength = 1 - fabsf(rotationStrength)/4;
            CGFloat scale = MAX(scaleStrength, 0.93);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngle);
            CGAffineTransform scaletransform = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaletransform;
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance);
            
            [self updateOverlay:xDistance];
            
            
            break;
        }
        case UIGestureRecognizerStateEnded:{
            if (xDistance > 60) {
                [self removeViewAnimations:xDistance yDis:yDistance];
                if ([_delegate respondsToSelector:@selector(remember)]) {
                    [_delegate remember];
                } else {NSLog(@"no responds to remember");}

            }
            else if (xDistance < -60){
                [self removeViewAnimations:xDistance yDis:yDistance];
                if ([_delegate respondsToSelector:@selector(onemore)]) {
                    [_delegate onemore];
                } else {NSLog(@"no responds to onemore");}
            }
            else [self resetViewPositionAndTransformations];
            break;
        }
        default:break;
            
    }
}

- (void)changeSubview
{
    [self addSubview:self.overlayView];
}

- (void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        self.overlayView.mode = GGOverlayViewModeRight;
    } else if (distance <= 0) {
        self.overlayView.mode = GGOverlayViewModeLeft;
    }
    CGFloat overlayStrength = MIN(fabsf(distance)/500, 0.3);
    self.overlayView.alpha = overlayStrength;
}

- (void)resetViewPositionAndTransformations
{
    [UIView animateWithDuration:0.2 animations:^{
        self.center = self.originalPoint;
        self.transform = CGAffineTransformMakeRotation(0);
        self.overlayView.alpha = 0;
    }];
}

- (void)removeViewAnimations:(CGFloat)xDis yDis:(CGFloat)yDis
{
    if (xDis>0) {
        xDis = MAX(xDis*4, 350);
    } else {xDis = MIN(xDis*4, -350);}
//    if (yDis>0) {
//        yDis = MAX(yDis*4, 350);
//    } else {
//        yDis = MIN(yDis*4, -350);
//    }
    yDis = yDis*4;
//    [UIView animateWithDuration:0.2 animations:^{
//        self.center = CGPointMake(self.originalPoint.x + xDis , self.originalPoint.y + yDis);
//        self.overlayView.alpha = 0.5;
//    }];
    NSLog(@"xDix = %f, yDis = %f",xDis,yDis);
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = CGPointMake(self.originalPoint.x + xDis , self.originalPoint.y + yDis);
        self.overlayView.alpha = 0.5;
    } completion:nil];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.7];

}


- (void)dealloc
{
    [self removeGestureRecognizer:self.panGestureRecognizer];
}
@end
