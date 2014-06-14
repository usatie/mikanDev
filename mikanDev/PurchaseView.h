//
//  PurchaseView.h
//  mikanDev
//
//  Created by Shun Usami on 2014/06/12.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@interface PurchaseView : UIView <SKProductsRequestDelegate>


@property UIButton* purchaseButton1;
@property UIButton* purchaseButton2;
@property UIButton* purchaseButton3;
@property UIButton* purchaseButton4;
@property UIButton* purchaseButton5;
@property UIView* purchaseButtonView1;
@property UIView* purchaseButtonView2;
@property UIView* purchaseButtonView3;
@property UIView* purchaseButtonView4;
@property UIView* purchaseButtonView5;

@property UIActivityIndicatorView* indicator;
@end
