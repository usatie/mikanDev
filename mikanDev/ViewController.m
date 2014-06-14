//
//  ViewController.m
//  mikanDev
//
//  Created by Shun Usami on 2014/06/04.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DefColor.h"
#import <StoreKit/StoreKit.h>


@interface ViewController ()<CheckViewDelegate>{
    UIView *rootView;
}

@end

@implementation ViewController

- (void) checkSetting
{
    _CheckBeginIndex = 350;
    _NumberOfCheck = 10;
}


- (void)viewDidLoad
{
    [self checkSetting];
    [super viewDidLoad];
    [self initView];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasLaunchedOnce"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // ２回目以降の起動時
        [self viewCheck:_goToCheckButton checkBeginIndex:_CheckBeginIndex numberOfCheck:0];
        NSLog(@"2回目！");
    }
    else
    {
        [self initUserDefaults];
//        [self.view addSubview:rootView];
//        [self showIntroWithCrossDissolve];
//        [_mainView addSubview:_navBar];
        [self introView];
        NSLog(@"1回目！");
    }
}
- (void) introView
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];//
    _imgView.image = [UIImage imageNamed:@"how_to_use"];
    [_mainView addSubview:_imgView];
    [self goTo:_goToCheckButtonIntro buttonView:_goToCheckButtonView];
    NSLog(@"%@", _imgView);
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) initMenuButton
{
    _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_menuButton addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_button2"]]];
    [_menuButton addTarget:self action:@selector(viewMenu:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_menuButton];
}

- (void) initView
{
    CGRect deviceScreenSize = [[UIScreen mainScreen] bounds];
    _screenW = deviceScreenSize.size.width;
    _screenH = deviceScreenSize.size.height;
    rootView = [[UIView alloc] initWithFrame:deviceScreenSize];
    
    [self initMenu];
    
    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    _mainView.layer.shadowOffset = CGSizeMake(0, 0);
    _mainView.layer.shadowRadius = 5;
    _mainView.layer.shadowOpacity = 1;
    [self.view addSubview:_mainView];
}

- (void) initUserDefaults
{
    NSLog(@"initUserDefaults");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"LearnList"];
    [userDefaults setInteger:30 forKey:@"TheNumberOfMikans"];
    [userDefaults synchronize];
}

- (void) initMenu
{
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    _menuView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    _menuView.contentSize = CGSizeMake(_screenW-50, _screenH*2);
    _menuItem0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenW, 64)];
    _menuItem1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, _screenW, 80)];
    _menuItem2 = [[UIView alloc] initWithFrame:CGRectMake(0, 144, _screenW, 80)];
    _menuItem3 = [[UIView alloc] initWithFrame:CGRectMake(0, 224, _screenW, 80)];
    _menuItem4 = [[UIView alloc] initWithFrame:CGRectMake(0, 304, _screenW, 80)];
    _menuItem5 = [[UIView alloc] initWithFrame:CGRectMake(0, 384, _screenW, 80)];
    [_menuView addSubview:_menuItem0];
    [_menuView addSubview:_menuItem1];
    [_menuView addSubview:_menuItem2];
    [_menuView addSubview:_menuItem3];
    [_menuView addSubview:_menuItem4];
    [_menuView addSubview:_menuItem5];
    _menuView.backgroundColor = [UIColor grayColor];
    
    self.view = _baseView;
    [_baseView addSubview:_menuView];
    
    [self initButton];
    [self callMenu];
}

- (void)goTo:(UIButton*)button buttonView:(UIView*)buttonView
{
    NSLog(@"welcome to gotoLearn, button = %@", button);
    [button removeFromSuperview];
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(35, 444, 250, 80)];
    buttonView.layer.cornerRadius = 5;
    buttonView.clipsToBounds = true;
    buttonView.backgroundColor = myColorTomato;
    [buttonView addSubview:button];
    [_mainView addSubview:buttonView];
}

- (void)goToMenu
{
    [self viewMenu:_menuButton];
}


- (void) goToCheck
{
    [self goTo:_goToCheckButton buttonView:_goToCheckButtonView];
}


- (void) goToAddMenu
{
    [self goTo:_goToAddMenuButton buttonView:_goToAddMenuButtonView];
}

- (void) callMenu
{
    [_labelMikans removeFromSuperview];
    [_addItemButton1 removeFromSuperview];
    [_addItemButton2 removeFromSuperview];
    [_addItemButton3 removeFromSuperview];
    [_addItemButton4 removeFromSuperview];
    [_addItemButton5 removeFromSuperview];
    
    [_menuItem1 addSubview:_menuItemButton1];
    [_menuItem2 addSubview:_menuItemButton2];
    [_menuItem3 addSubview:_menuItemButton3];
    [_menuItem4 addSubview:_menuItemButton4];
}

- (void) callAdd
{
    [_menuItemButton1 removeFromSuperview];
    [_menuItemButton2 removeFromSuperview];
    [_menuItemButton3 removeFromSuperview];
    [_menuItemButton4 removeFromSuperview];
    
    _labelMikans.text = [NSString stringWithFormat:@"みかん所持数：%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"]];
    [_menuItem0 addSubview:_labelMikans];
    [_menuItem1 addSubview:_addItemButton1];
    [_menuItem2 addSubview:_addItemButton2];
    [_menuItem3 addSubview:_addItemButton3];
    [_menuItem4 addSubview:_addItemButton4];
    [_menuItem5 addSubview:_addItemButton5];
}

- (void) initButton
{
    _menuItemButton1 = [self menuButton:@"star" label:@"Learn" selector:@selector(viewLearn:) mode:YES];
    _menuItemButton2 = [self menuButton:@"invite" label:@"Invite" selector:@selector(viewInvite:) mode:YES];
    _menuItemButton3 = [self menuButton:@"gear" label:@"Setting" selector:@selector(viewSetting:) mode:YES];
    _menuItemButton4 = [self menuButton:@"orange" label:@"mikan Shop" selector:@selector(pressLauchStore) mode:YES];
    _goToCheckButton = [self menuButton:@"star" label:@"Learn Now" selector:@selector(viewLearn:) mode:YES];
    _goToCheckButtonIntro = [self menuButton:@"star" label:@"Learn Now" selector:@selector(viewCheck1:) mode:YES];
    _goToAddMenuButton = [self menuButton:@"plus.png" label:@"Add More !" selector:@selector(viewAdd:) mode:YES];
    
    _addItemButton1 = [self menuButton:@"1" label:@"TOEFL rank3-1" selector:@selector(viewCheck1:) mode:NO];
    _addItemButton2 = [self menuButton:@"2" label:@"TOEFL rank3-2" selector:@selector(viewCheck2:) mode:NO];
    _addItemButton3 = [self menuButton:@"3" label:@"TOEFL rank3-3" selector:@selector(viewCheck3:) mode:NO];
    _addItemButton4 = [self menuButton:@"4" label:@"TOEFL rank3-4" selector:@selector(viewCheck4:) mode:NO];
    _addItemButton5 = [self menuButton:@"5" label:@"TOEFL rank3-5" selector:@selector(viewCheck4:) mode:NO];
    
    _labelMikans = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 240, 64)];
    _labelMikans.text = [NSString stringWithFormat:@"みかん所持数：%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"]];
}

- (UIButton *) menuButton:(NSString*)imageName label:(NSString*)labelText selector:(SEL)func mode:(BOOL)mode
{
    int width;
    if (mode == YES) {
        width = 0;
    } else {
        width = 70;
    }
    
    UIImage *circle = [self imageFillEllipseWithColor:[UIColor whiteColor] size:CGSizeMake(50, 50)];
    UIImageView *circleView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
    circleView.image = circle;
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 40, 40)];
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 80)];
    iconView.image = [UIImage imageNamed:imageName];
    menuLabel.text = labelText;
    menuLabel.textColor = [UIColor whiteColor];
    menuLabel.font = [UIFont systemFontOfSize:20];
    UIButton* menuItemButton = [[UIButton alloc] initWithFrame:CGRectMake(0+width, 0, 320, 80)];
    [menuItemButton addTarget:self action:func forControlEvents:UIControlEventTouchUpInside];
    [menuItemButton addSubview:circleView];
    [menuItemButton addSubview:iconView];
    [menuItemButton addSubview:menuLabel];
    
    return menuItemButton;
}

- (void) viewLearn:(UIButton *)button
{
    NSLog(@"%@ called", NSStringFromSelector(_cmd));
    for (UIView *view in [_mainView subviews]) {
        [view removeFromSuperview];
    }
    
    _checkView = [[CheckView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    _checkView.checkBeginIndex = _CheckBeginIndex;
    _checkView.numberOfCheck = 0;
    _checkView.delegate = self;
    
    [_mainView addSubview:_checkView];
    
    [self menuHide];
    _menuIndex = 0;
    _addIndex = 0;
}

- (void) viewCheck:(UIButton *)button checkBeginIndex:(int)begin numberOfCheck:(int)number
{
    NSLog(@"%@ called", NSStringFromSelector(_cmd));
    for (UIView *view in [_mainView subviews]) {
        [view removeFromSuperview];
    }
    [self consumeMikans:1];
    
    _checkView = [[CheckView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    _checkView.checkBeginIndex = begin;
    _checkView.numberOfCheck = number;
    _checkView.delegate = self;
    
    [_mainView addSubview:_checkView];
    
    [self menuHide];
    _menuIndex = 0;
    _addIndex = 0;
}

- (void) viewCheck1:(UIButton *)button
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"] == 0) {
        [self mikanAlert];
    } else [self viewCheck:button checkBeginIndex:_CheckBeginIndex numberOfCheck:_NumberOfCheck];
}
- (void) viewCheck2:(UIButton *)button
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"] == 0) {
        [self mikanAlert];
    } else [self viewCheck:button checkBeginIndex:_CheckBeginIndex + _NumberOfCheck*1 numberOfCheck:_NumberOfCheck];
}
- (void) viewCheck3:(UIButton *)button
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"] == 0) {
        [self mikanAlert];
    } else [self viewCheck:button checkBeginIndex:_CheckBeginIndex + _NumberOfCheck*2 numberOfCheck:_NumberOfCheck];
}
- (void) viewCheck4:(UIButton *)button
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"] == 0) {
        [self mikanAlert];
    } else [self viewCheck:button checkBeginIndex:_CheckBeginIndex + _NumberOfCheck*3 numberOfCheck:_NumberOfCheck];
}

- (void) viewCheck5:(UIButton *)button
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"] == 0) {
        [self mikanAlert];
    } else [self viewCheck:button checkBeginIndex:_CheckBeginIndex + _NumberOfCheck*4 numberOfCheck:_NumberOfCheck];
}
- (void) mikanAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"みかんが足りない！" message:@"１回：みかん１個\nみかん所持数：０個" delegate:self cancelButtonTitle:nil otherButtonTitles:@"購入", nil];
    [alert show];
}

- (void) consumeMikans:(int)mikansUse
{
    int  i = [[NSUserDefaults standardUserDefaults] integerForKey:@"TheNumberOfMikans"];
    i -= mikansUse;
    _labelMikans.text = [NSString stringWithFormat:@"みかん所持数：%d", i];
    NSLog(@"みかん所持数 = %d", i);
    [[NSUserDefaults standardUserDefaults] setInteger:i forKey:@"TheNumberOfMikans"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex(%d)", (int)buttonIndex);
    [self pressLauchStore];
}

- (void)pressLauchStore
{
    if([SKPaymentQueue canMakePayments]){
//        MixiStoreViewController *storeVC = [[MixiStoreViewController alloc] init];
//        [self presentViewController:storeVC animated:YES completion:nil];
        NSLog(@"設定はOK");
        [self viewPurchase];
    }else{
        NSLog(@"設定で off にされてる。");
    }
}

- (void) viewInvite:(UIButton *)button
{
    for (UIView *view in [_mainView subviews]) {
        [view removeFromSuperview];
    }

    _inviteView = [[inviteView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    [_mainView addSubview:_inviteView];
    
    
    [self initMenuButton];
    [self menuHide];
    _menuIndex = 0;
    _addIndex = 0;
    
}
- (void) viewSetting:(UIButton *)button
{

    for (UIView *view in [_mainView subviews]) {
        [view removeFromSuperview];
    }
//    _inviteView = [[inviteView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
//    [_mainView addSubview:_inviteView];
    _purchaseView = [[PurchaseView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    [_mainView addSubview:_purchaseView];

    [self initMenuButton];
    [self menuHide];
    _menuIndex = 0;
    _addIndex = 0;
}

- (void) viewPurchase
{
    
    for (UIView *view in [_mainView subviews]) {
        [view removeFromSuperview];
    }
    _purchaseView = [[PurchaseView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    [_mainView addSubview:_purchaseView];
    
    [self initMenuButton];
    [self menuHide];
    _menuIndex = 0;
    _addIndex = 0;
}

- (void) viewMenu:(UIButton *)button
{
    NSLog(@"%@ called", NSStringFromSelector(_cmd));
    if (!_menuIndex) {
        [self menuAppear];
        _menuIndex = 1;
    } else {
        [self menuHide];
        _menuIndex = 0;
    }
}
- (void) menuAppear
{
    [self callMenu];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        _mainView.transform = CGAffineTransformTranslate(transform, 250, 0);
    } completion:nil];
}


- (void) menuHide
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        _mainView.transform = CGAffineTransformTranslate(transform, 0, 0);
    } completion:nil];
}

- (void) viewAdd:(UIButton *)button
{
    NSLog(@"%@ called", NSStringFromSelector(_cmd));
    if (!_addIndex) {
        [self addAppear];
        _addIndex = 1;
    } else {
        [self addHide];
        _addIndex = 0;
    }
}
- (void) addAppear
{
    [self callAdd];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        _mainView.transform = CGAffineTransformTranslate(transform, -250, 0);
    } completion:nil];
}


- (void) addHide
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        _mainView.transform = CGAffineTransformTranslate(transform, 0, 0);
    } completion:nil];
}




- (UIImage *)imageFillEllipseWithColor:(UIColor *)color size:(CGSize)size
{
    UIImage *image = nil;
    
    // ビットマップ形式のグラフィックスコンテキストの生成
    UIGraphicsBeginImageContextWithOptions(size, 0.f, 0);
    
    // 現在のグラフィックスコンテキストを取得する
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 塗りつぶす領域を決める
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextStrokeEllipseInRect(context, rect);
    
    // 現在のグラフィックスコンテキストの画像を取得する
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 現在のグラフィックスコンテキストへの編集を終了
    // (スタックの先頭から削除する)
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImageView *)imageViewSizeChange:(NSString*)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 60, 290, 400)];
    UIImage *image = [UIImage  imageNamed:@"imageName"];
    float x = image.size.width;
    float y = image.size.height;
    float x2 = y*290.0/400.0;
    NSLog(@"%f %f %f %f %f",x, y,290.0, 400.0, x2);
    CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, x2, y));
    UIImage *useimage = [UIImage imageWithCGImage:cgImage];
    imageView.image = useimage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.alpha = 0.8;

    return imageView;
}


- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello!";
    page1.desc = @"ほんとはここでちゃんと説明をするよ";
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Easy Easy!";
    page2.desc = @"でも今はまだ超カンタンに！";
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Pon Pon Pon!";
    page3.desc = @"単語カードがポンポン出てくるよ！";
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Poi Poi Poi Poi!";
    page4.desc = @"知らない単語は左へポイ！\n知ってる単語は右にポイ！\nさあ始めよう！";
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];

    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    intro.backgroundColor = [UIColor whiteColor];
    
    [intro showInView:rootView animateDuration:0.3];
    NSLog(@"きたよ");
}

- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"introDidFinish callback");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [rootView removeFromSuperview];
    _checkView = [[CheckView alloc] initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
    _checkView.checkBeginIndex = _CheckBeginIndex;
    _checkView.numberOfCheck = _NumberOfCheck;
    _checkView.delegate = self;
    NSLog(@"c");
    [_mainView addSubview:_checkView];
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
