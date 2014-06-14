//
//  CheckView.h
//  TinderLikeAnimations2
//
//  Created by Shun Usami on 2014/05/28.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGDraggableView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SAProgressBarView.h"

@protocol CheckViewDelegate;

@interface CheckView : UIView <GGDraggableViewDelegate>

//VocabularyCountより
@property (nonatomic, assign) id<CheckViewDelegate> delegate;
@property NSMutableArray* counter;
@property NSMutableArray* englishArray;
@property int index;
@property int index2;
@property int i;
@property int display_switch;
@property int words_count;
@property int checkBeginIndex;
@property int numberOfCheck;
@property BOOL nextTurn;
@property BOOL skip;
@property BOOL saved;
@property BOOL  IsTimerValid;
@property NSDate *started;
@property UILabel *englishLabel;
@property UILabel *CounterLabel;
@property UILabel *japaneseLabel;
@property UILabel *numberLabel;
@property UILabel *englishLabel2;
@property UILabel *CounterLabel2;
@property UILabel *japaneseLabel2;
@property UILabel *numberLabel2;
@property UILabel *wordsNumer;
@property UILabel *wordsDenom;
@property UIButton *menuButton;
//Timer関連
@property UILabel *timerLabel;
@property (nonatomic, assign) NSTimer *timer; //クイズ中の経過時間を生成する
@property int countDown;  //設定時間
@property SAProgressBarView* progressView;
//kokomade
@end

@protocol CheckViewDelegate <NSObject>
@optional
- (void)goToCheck;
- (void)goToAddMenu;
- (void)goToMenu;
@end