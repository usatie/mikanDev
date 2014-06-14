//
//  CheckView.m
//  TinderLikeAnimations2
//
//  Created by Shun Usami on 2014/05/28.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "CheckView.h"
#import "DefColor.h"

@interface CheckView () <GGDraggableViewDelegate>
@property (nonatomic, strong) GGDraggableView *draggableView1;
@property (nonatomic, strong) GGDraggableView *draggableView2;
@end

@implementation CheckView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.frame = frame;
    self.backgroundColor = myColorMikanLogo;//myColorPalegreen;
    
    [self initProgress];
    [_progressView setProgress:0];
    [self initMenuButton];
    [self initLabel];
    [self performSelector:@selector(sleep) withObject:nil afterDelay:0.1]; //init の後にreadNumberに書き込む暇を与えるため
    return self;
}

- (void) initMenuButton
{
    _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_menuButton addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_button2"]]];
    [_menuButton addTarget:self action:@selector(goToMenuDelegate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_menuButton];
}


- (void) sleep
{
    [self csvRead];
    
    NSLog(@"%@", _englishArray);
    if (_words_count>1) {
        NSLog(@"a");
        [self pronounce:_index2];
        NSLog(@"b");
        _index = 0;
        _index2 = 1;
        _started = [NSDate date];
        [self TimerStart];
        [self loadDraggableCustomView];
    } else {
        [self goToAddDelegate];
    }
    
    _display_switch = 0;
    
    _wordsNumer.text = [NSString stringWithFormat:@"%d",_englishArray.count - _words_count];
    _wordsDenom.text = [NSString stringWithFormat:@" / %d",_englishArray.count];
}

- (void)remember
{
    [self TimerStart];
    NSLog(@"remember");
    if (_skip) {
        [self pronounce:_index];
        [self displayLabelWithSwitch];
        _skip = NO;
    } else {
        if(_words_count>0) _words_count--;
        [self initProgress];
        [self Progress];
        [self counterPlus:1];
        [self indexPlus];
        NSLog(@"%@, index = %d, switch = %d", _counter, _index, _display_switch);
        [self displayLabelWithSwitch];
    }
    
    if (!_nextTurn) {
        [self pronounce:_index];
    } else {
        [self alerm];
        [self next];
        _nextTurn = NO;
        _skip = YES;
    }
}

- (void)onemore
{
    [self TimerStart];
    NSLog(@"onemore");
    if (_skip) {
        [self pronounce:_index];
        [self displayLabelWithSwitch];
        _skip = NO;
    } else {
        [self counterPlus:10];
        [self indexPlus];
        NSLog(@"%@, index = %d, switch = %d", _counter, _index, _display_switch);
        [self displayLabelWithSwitch];
     }
    if (!_nextTurn) {
        [self pronounce:_index];
    } else {
        [self alerm];
        [self next];
        _nextTurn = NO;
        _skip = YES;
    }

}

-(void)TimerStart
{
    if (_IsTimerValid == YES) {
        [_timer invalidate];
    }
    _IsTimerValid = YES;
    _timer = [NSTimer
              scheduledTimerWithTimeInterval:1
              target: self
              selector:@selector(TimerAction)
              userInfo:nil
              repeats:YES];
    _timerLabel.text = [NSString stringWithFormat:@"3"];
    NSLog(@"timerstart");
    _countDown = 2;
}

-(void)TimerAction{

    if(_countDown>0){                                                       //timerLabelに表示
        _timerLabel.text = [NSString stringWithFormat:@"%d", _countDown];
        _countDown--;
    }else if (_countDown == 0){                                             //japaneseLabel表示
        [self japaneseDisplayIfTouched];
        NSLog(@"countdown = %d", _countDown);
        if (!_skip) {
            [self pronounce:_index];
        } else {
            [self alerm];
        }
        
        _timerLabel.text = @"0";
        _countDown--;
        NSLog(@"---------タイムオーバ-----------");
    } else {                                                                //Time out and remove the current view
        [_timer invalidate]; // タイマーを停止する
        if (_display_switch == 0) {
            NSLog(@"draggable1");
            [self removeViewAnimations:_draggableView1];
            [self onemore];
        } else {
            NSLog(@"draggable2");
            [self removeViewAnimations:_draggableView2];
            [self onemore];
        }
        NSLog(@"Time out and remove the current draggable view.");
    }
}

- (void)removeViewAnimations: (GGDraggableView *)DraggableView
{
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        DraggableView.center = CGPointMake(DraggableView.originalPoint.x - 250 , DraggableView.originalPoint.y + 400);
        DraggableView.overlayView.alpha = 0.5;
        CGAffineTransform transform = CGAffineTransformMakeRotation(-0.5);
        CGAffineTransform scaletransform = CGAffineTransformScale(transform, 1, 1);
        DraggableView.transform = scaletransform;
    } completion:nil];
    [DraggableView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}

- (void)csvRead
{
    NSString *csvFile = [[NSBundle mainBundle] pathForResource:@"toefl_rank3" ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
    NSScanner *scanner = [NSScanner scannerWithString:csv];
    
    NSCharacterSet *chSet = [NSCharacterSet newlineCharacterSet];
    NSString *line;
    NSMutableArray *toefl_rank3 = [[NSMutableArray alloc] init];
    NSMutableArray *count_init = [[NSMutableArray alloc] init];
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:chSet intoString:&line];
        NSArray *array = [line componentsSeparatedByString:@","];
        [toefl_rank3 addObject:array];
        [count_init addObject:@0];
        [scanner scanCharactersFromSet:chSet intoString:NULL];
    }
    //部分配列のコピー
    NSLog(@"checkbeginindex%d",_checkBeginIndex);
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_checkBeginIndex, _numberOfCheck)];
    _englishArray = [NSMutableArray arrayWithArray:[toefl_rank3 objectsAtIndexes:indexes]];
    NSLog(@"%@", _englishArray);
    [self loadUserDefaults];
}

- (void)loadDraggableCustomView
{
    self.draggableView1 = [[GGDraggableView alloc] initWithFrame:CGRectMake(15, 80, 290, 260)];
    self.draggableView2 = [[GGDraggableView alloc] initWithFrame:CGRectMake(15, 80, 290, 260)];
    
    self.draggableView1.delegate = self;
    self.draggableView2.delegate = self;
    
    [self labelDisplayAtFirst];
    [self labelDisplayBelow2];
    [self addSubview:self.draggableView2];
    [self addSubview:self.draggableView1];
}

- (void)initLabelsOnCards:(UILabel*)english japanese:(UILabel*)japanese counter:(UILabel*)counter number:(UILabel*)number
{
    english.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
    english.textAlignment = NSTextAlignmentCenter;
    japanese.font = [UIFont fontWithName:@"Helvetica" size:20];
    japanese.textAlignment = NSTextAlignmentCenter;
    counter.font = [UIFont fontWithName:@"Helvetica" size:8];
    number.font = [UIFont fontWithName:@"Helvetica" size:8];
}

- (void)initLabel
{
    _englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 290, 50)];
    _japaneseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 290, 30)];
    _CounterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 30)];
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];

    _englishLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 290, 50)];
    _japaneseLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 290, 30)];
    _CounterLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 30)];
    _numberLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];

    [self initLabelsOnCards:_englishLabel japanese:_japaneseLabel counter:_CounterLabel number:_numberLabel];
    [self initLabelsOnCards:_englishLabel2 japanese:_japaneseLabel2 counter:_CounterLabel2 number:_numberLabel2];

    _wordsNumer = [[UILabel alloc] initWithFrame:CGRectMake(265, 0, 75, 50)];
    _wordsDenom = [[UILabel alloc] initWithFrame:CGRectMake(275, 0, 75, 50)];
    _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 350, 320, 100)];
    
    _wordsNumer.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    _wordsNumer.textColor = myColorTomatoRed;
    _wordsNumer.numberOfLines = 2;
    

    _wordsDenom.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    _wordsDenom.textColor = [UIColor whiteColor];

    _timerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _timerLabel.textColor = [UIColor whiteColor];
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_wordsNumer];
    [self addSubview:_wordsDenom];
    [self addSubview:_timerLabel];
}

- (void)displayLabelWithSwitch
{
    if (_display_switch == 0) {
        NSLog(@"Switch 1");
        self.draggableView1 = [[GGDraggableView alloc] initWithFrame:CGRectMake(15, 80, 290, 260)];
        self.draggableView1.delegate = self;
        if (_words_count > 0) {
            [self labelDisplayBelow1];
            _wordsNumer.text = [NSString stringWithFormat:@"%d",_englishArray.count - _words_count];
        } else {
            [self labelFinish];
            _nextTurn = 0;
        }
        [self addSubview:self.draggableView1];
        [self sendSubviewToBack:self.draggableView1];
        _display_switch ++;
    } else {
        NSLog(@"Switch 2");
        self.draggableView2 = [[GGDraggableView alloc] initWithFrame:CGRectMake(15, 80, 290, 260)];
        self.draggableView2.delegate = self;
        if (_words_count > 0) {
            [self labelDisplayBelow2];
            _wordsNumer.text = [NSString stringWithFormat:@"%d",_englishArray.count - _words_count];
        } else {
            [self labelFinish];
            _nextTurn = 0;
        }
        [self addSubview:self.draggableView2];
        [self sendSubviewToBack:self.draggableView2];
        _display_switch =0;
    }
}

- (void)labelDisplayAtFirst
{
    [self labelDis:_numberLabel english:_englishLabel japanese:_japaneseLabel counter:_CounterLabel index:_index];
    [self.draggableView1 addSubview:_englishLabel];
    [self.draggableView1 addSubview:_japaneseLabel];
    [self.draggableView1 addSubview:_numberLabel];
    [self.draggableView1 addSubview:_CounterLabel];
}

- (void)labelDisplayBelow1
{
    [self labelDis:_numberLabel english:_englishLabel japanese:_japaneseLabel counter:_CounterLabel index:_index2];
    [self.draggableView1 addSubview:_englishLabel];
    [self.draggableView1 addSubview:_japaneseLabel];
    [self.draggableView1 addSubview:_numberLabel];
    [self.draggableView1 addSubview:_CounterLabel];
}


- (void)labelDisplayBelow2
{
    [self labelDis:_numberLabel2 english:_englishLabel2 japanese:_japaneseLabel2 counter:_CounterLabel2 index:_index2];
    [self.draggableView2 addSubview:_englishLabel2];
    [self.draggableView2 addSubview:_japaneseLabel2];
    [self.draggableView2 addSubview:_numberLabel2];
    [self.draggableView2 addSubview:_CounterLabel2];
}

- (void)labelDis:(UILabel*)number english:(UILabel*)english japanese:(UILabel*)japanese counter:(UILabel*)counter index:(int)index
{
    int a = [_counter[_index] intValue];
    number.text = _englishArray[index][0];
    english.text = _englishArray[index][1];
    japanese.text = nil;
    counter.text = [NSString stringWithFormat:@"%d回目", a/10+1];
}

- (void)next
{
    int a = [_counter[_index2] intValue];
    NSLog(@"welcome to NEXT");
    if (_display_switch == 0) {
        //labeling
        _englishLabel2.text = [NSString stringWithFormat:@"%d周目",a/10+1];
        _numberLabel2.text = nil;
        _CounterLabel2.text = nil;
        _japaneseLabel2.text = @"めくっていいよ";
        _draggableView2.backgroundColor = myColorTomato;
        [self bringSubviewToFront:self.draggableView2];
        NSLog(@"1ban");
        NSLog(@"_englishlabel = %@",_englishLabel);
        
        _display_switch = 1;
    } else {
        //labeling
        _englishLabel.text = [NSString stringWithFormat:@"%d周目",a/10+1];
        _numberLabel.text = nil;
        _CounterLabel.text = nil;
        _japaneseLabel.text = @"めくっていいよ";
        _draggableView1.backgroundColor = myColorWakatake;
        [self bringSubviewToFront:self.draggableView1];
        NSLog(@"2ban");
        NSLog(@"_englishlabel2 = %@",_englishLabel2);
        
        _display_switch = 0;
    }
//    if (a%30 == 0) self.backgroundColor = myColorWakatake/*Khaki;*/;
//    if (a%30 == 10) self.backgroundColor = myColorIceGreen/*Apricot;*/;
//    if (a%30 == 20) self.backgroundColor = myColorPink/*MikanLogo;*/;
}

- (void)japaneseDisplayIfTouched
{
    if (!_skip) {
        if (_words_count>0) {
            if (_display_switch == 0) {
                [self japaneseDisplay1];
            } else {
                [self japaneseDisplay2];
            }
        }
    }
}

- (void)japaneseDisplay1
{
    _japaneseLabel.text = _englishArray[_index][2];
    NSLog(@"japanese 1");
}
- (void)japaneseDisplay2
{
    _japaneseLabel2.text = _englishArray[_index][2];
    NSLog(@"japanese 2");
}

- (void)labelFinish
{
    if (_IsTimerValid) {
        [_timer invalidate];
        _IsTimerValid = NO;
        NSLog(@"timer Invalidate");
    }

    [_timerLabel removeFromSuperview];
    if (_display_switch == 0) {
        [self labelFinish2];
    } else {
        [self labelFinish1];
    }
    [_wordsDenom removeFromSuperview];
    if (!_saved) {
        NSUInteger numberOfLearnList = [self saveUserDefaults];
        if (numberOfLearnList > 5) {
            [self goToLearnDelegate];
            _wordsNumer.text = [NSString stringWithFormat:@"%d単語\n完璧",_englishArray.count - (int)numberOfLearnList];
        } else {
            [self goToAddDelegate];
            _wordsNumer.text = [NSString stringWithFormat:@"%d単語\n覚えた",_englishArray.count - (int)numberOfLearnList];
        }
    }
}

- (void)labelFinish1
{
    [self labelFinishMake:_numberLabel english:_englishLabel japanese:_japaneseLabel counter:_CounterLabel view:_draggableView1];
}

- (void)labelFinish2
{
    [self labelFinishMake:_numberLabel2 english:_englishLabel2 japanese:_japaneseLabel2 counter:_CounterLabel2 view:_draggableView2];
}

- (void)labelFinishMake:(UILabel*)number english:(UILabel*)english japanese:(UILabel*)japanese counter:(UILabel*)counter view:(UIView*)view
{
    number.text = 0;
    english.text = @"Finished !";
    counter.text = @"よっ天才！";
    
    [view addSubview:english];
    [view addSubview:japanese];
    [view addSubview:number];
    [view addSubview:counter];
    
    NSTimeInterval elapsed = [_started timeIntervalSinceNow];
    NSLog(@"Elapsed: %.2fs", elapsed);
    japanese.text = [NSString stringWithFormat:@"%.1f秒でLearned !", -elapsed];
}


- (void)goToLearnDelegate
{
    if ([_delegate respondsToSelector:@selector(goToCheck)]) {
        [_delegate goToCheck];
    } else NSLog(@"no responds to goToLearn");
}

- (void)goToAddDelegate
{
    if ([_delegate respondsToSelector:@selector(goToAddMenu)]) {
        [_delegate goToAddMenu];
    } else NSLog(@"no responds to goToAdd");
}

- (void)goToMenuDelegate
{
    if (_IsTimerValid == YES) {
        [_timer invalidate];
        _IsTimerValid = NO;
    } //else {
//        if (_englishArray.count > 1) {
//            [self TimerStart];
//        }
//    }
    if ([_delegate respondsToSelector:@selector(goToMenu)]) {
        [_delegate goToMenu];
    } else NSLog(@"no responds to goToMenu");
}

- (void)indexPlus
{
    if (_index +1 == _englishArray.count) {
        _index = 0;
        _nextTurn = YES;
    } else _index++;
    while ([_counter[_index] intValue]%10 != 0) {
        if(_words_count == 0) {
            break;
        }
        if (_index +1 == _englishArray.count) {
            _index = 0;
            _nextTurn = YES;
        } else _index++;
    }
    
    if (_index2 +1 == _englishArray.count) {
        _index2 = 0;
    } else _index2++;
    while ([_counter[_index2] intValue]%10 != 0) {
        if(_words_count == 0) {
            break;
        }
        if (_index2 +1 == _englishArray.count) {
            _index2 = 0;
        } else _index2++;
    }
    
    NSLog(@"index = %d, index2 = %d, indexPlus",_index , _index2);
}

- (void)counterPlus:(int)plus
{
    _i = [_counter[_index] intValue]+plus;
    [_counter replaceObjectAtIndex:_index withObject:[NSNumber numberWithInt:_i]];
}

- (void)pronounce:(int)index
{
    SystemSoundID soundID;
    NSURL* soundURL = [[NSURL alloc] init];
    if (_words_count == 0) {
        soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Finish" ofType:@"caf"]];
    } else {
        soundURL = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@", _englishArray[index][1]] withExtension:@"mp3"];
    }
    AudioServicesCreateSystemSoundID ((CFURLRef)CFBridgingRetain(soundURL), &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (void)alerm
{
    SystemSoundID soundID;
    NSURL* soundURL = [[NSURL alloc] init];
    soundURL = [[NSBundle mainBundle] URLForResource:@"drum-japanese2" withExtension:@"mp3"];
    AudioServicesCreateSystemSoundID ((CFURLRef)CFBridgingRetain(soundURL), &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (NSUInteger)saveUserDefaults
{
    //Save UserDefaults at last
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"LearnList"];
    NSMutableArray *array = [[NSMutableArray alloc] init];

    if (_checkBeginIndex != 997) {
        for (int i = 0; i<_englishArray.count; i++) {
            NSLog(@"%d, %@, %@",i,_counter[i],_englishArray[i]);
            if ([_counter[i] intValue] >= 10) {
                [array addObject:_englishArray[i]];
            }
        }
        [userDefaults setObject:array forKey:@"LearnList"];
        [userDefaults synchronize];
    }    
    _saved = YES;
    return array.count;
}

- (void)loadUserDefaults
{
    //Load UserDefaults and Add 10 words at first
    _counter = [[NSMutableArray alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefaults objectForKey:@"LearnList"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    array = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i<self.numberOfCheck; i++) {
        [array addObject:_englishArray[i]];
    }
    [array addObjectsFromArray:arr];
    _englishArray = array;
    _words_count = (int)_englishArray.count;
    for (int i = 0; i<_words_count; i++) {
        [_counter addObject:@0];
    }
}

- (void)initProgress
{
    [_progressView removeFromSuperview];
    //初期化
    _progressView = [[SAProgressBarView alloc] initWithFrame:CGRectMake(75, 20, 170, 10)];
    //下地の色
    [_progressView backgroundColor:myColorChampagne];
    //バーの色
    [_progressView fillColor:myColorPalegreen];
    //ビューに登録
    [self addSubview:_progressView];
}

- (void) Progress
{
    float a = (float)(_words_count+1)/_englishArray.count;
    float b = (float)(_words_count)/_englishArray.count;
    a = 1-a;
    b = 1-b;
    NSLog(@"1-a = %f, 1-b = %f",a,b);
    [_progressView risingAnimationWithDuration:1.0f
                                 startProgress:a
                                   endProgress:b
                                         loops:0
                                   maxDelegate:self
                                   maxSelector:@selector(maxHandler)
                              completeDelegate:self
                              completeSelector:nil//@selector(completeHandler)
     ];
}

- (void)maxHandler {
    //ゲージがいっぱいになったときのイベント
    [_progressView fillColor:[UIColor greenColor]];
}

- (void)completeHandler {
    //ゲージの増加アニメーションが終わったときのイベント
    [_progressView fillColor:[UIColor purpleColor]];
}
@end
