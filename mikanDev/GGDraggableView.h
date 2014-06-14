//
//  GGDraggableView.h
//  TinderLikeAnimations2
//
//  Created by Shun Usami on 2014/05/21.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGOverlayView.h"
@protocol GGDraggableViewDelegate;

@interface GGDraggableView : UIView
@property (nonatomic, assign) id<GGDraggableViewDelegate> delegate;//delegate用
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint originalPoint;
@property (nonatomic, strong) GGOverlayView *overlayView;
@property int i;
@end

//kokokara
@protocol GGDraggableViewDelegate <NSObject>
@optional
- (void)remember;
- (void)onemore;
- (void)japaneseDisplayIfTouched;
@end
//kokomade delegate

