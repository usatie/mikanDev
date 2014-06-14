//
//  PurchaseView.m
//  mikanDev
//
//  Created by Shun Usami on 2014/06/12.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "PurchaseView.h"
#import "MyStoreObserver.h"
#import "DefColor.h"
#import "MBProgressHUD.h"


@interface PurchaseView ()<MyStoreObserverDelegate>

@end


@implementation PurchaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.backgroundColor = myColorMikanLogo;
    mySKObserver.delegate = self;
    
    _purchaseButton1 = [self menuButton:@"orange" label:@"みかん　1個" selector:@selector(makeRequest1) mode:YES];
    _purchaseButton2 = [self menuButton:@"orange" label:@"みかん　6個" selector:@selector(makeRequest2) mode:YES];
    _purchaseButton3 = [self menuButton:@"orange" label:@"みかん　12個" selector:@selector(makeRequest3) mode:YES];
    _purchaseButton4 = [self menuButton:@"orange" label:@"みかん　30個" selector:@selector(makeRequest4) mode:YES];
    _purchaseButton5 = [self menuButton:@"orange" label:@"みかん　60個" selector:@selector(makeRequest5) mode:YES];
    
    [self goTo:_purchaseButton1 buttonView:_purchaseButtonView1 number:1];
    [self goTo:_purchaseButton2 buttonView:_purchaseButtonView2 number:2];
    [self goTo:_purchaseButton3 buttonView:_purchaseButtonView3 number:3];
    [self goTo:_purchaseButton4 buttonView:_purchaseButtonView4 number:4];
    [self goTo:_purchaseButton5 buttonView:_purchaseButtonView5 number:5];
    
    return self;
}

- (void)makeRequest1
{
    // In-App purchase に登録してあるプロダクト情報を取得するためのリクエスト作成
    [self ShowActivityIndicator];
    NSSet *productIDs = [NSSet setWithObject:@"link.mikan.mikanDev.consumable_test1"];
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
    request.delegate = self;
    [request start];
}

- (void)makeRequest2
{
    // In-App purchase に登録してあるプロダクト情報を取得するためのリクエスト作成
    [self ShowActivityIndicator];
    NSSet *productIDs = [NSSet setWithObject:@"link.mikan.mikanDev.consumable_test2"];
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
    request.delegate = self;
    [request start];
}

- (void)makeRequest3
{
    // In-App purchase に登録してあるプロダクト情報を取得するためのリクエスト作成
    [self ShowActivityIndicator];
    NSSet *productIDs = [NSSet setWithObject:@"link.mikan.mikanDev.consumable_test3"];
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
    request.delegate = self;
    [request start];
}

- (void)makeRequest4
{
    // In-App purchase に登録してあるプロダクト情報を取得するためのリクエスト作成
    [self ShowActivityIndicator];
    NSSet *productIDs = [NSSet setWithObject:@"link.mikan.mikanDev.consumable_test4"];
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
    request.delegate = self;
    [request start];
}

- (void)makeRequest5
{
    // In-App purchase に登録してあるプロダクト情報を取得するためのリクエスト作成
    [self ShowActivityIndicator];
    NSSet *productIDs = [NSSet setWithObject:@"link.mikan.mikanDev.consumable_test5"];
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
    request.delegate = self;
    [request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    // 無効なアイテムがないかチェック
    NSLog(@"productsRequest");
    if ([response.invalidProductIdentifiers count] > 0) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                        message:@"アイテムIDが不正です。"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    // 購入処理開始
    [[SKPaymentQueue defaultQueue] addTransactionObserver:mySKObserver];
    for (SKProduct *product in response.products) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

- (void)goTo:(UIButton*)button buttonView:(UIView*)buttonView number:(int)number
{
    NSLog(@"welcome to gotoLearn, button = %@", button);
    [button removeFromSuperview];
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(35, 64+ 100*(number-1), 250, 80)];
    buttonView.layer.cornerRadius = 5;
    buttonView.clipsToBounds = true;
    buttonView.backgroundColor = myColorTomato;
    [buttonView addSubview:button];
    [self addSubview:buttonView];
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

-(void)ShowActivityIndicator
{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hideActivityIndicator
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

@end
