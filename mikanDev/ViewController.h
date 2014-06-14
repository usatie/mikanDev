//
//  ViewController.h
//  mikanDev
//
//  Created by Shun Usami on 2014/06/04.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
#import "LearnView.h"
#import "CheckView.h"
#import "inviteView.h"
#import "EAIntroView/EAIntroView.h"
#import "PurchaseView.h"


@interface ViewController : UIViewController <EAIntroDelegate>

@property UILabel* labelMikans;
@property(strong, nonatomic) UIButton* addItemButton1;
@property(strong, nonatomic) UIButton* addItemButton2;
@property(strong, nonatomic) UIButton* addItemButton3;
@property(strong, nonatomic) UIButton* addItemButton4;
@property(strong, nonatomic) UIButton* addItemButton5;
@property(strong, nonatomic) UIButton* menuItemButton1;
@property(strong, nonatomic) UIButton* menuItemButton2;
@property(strong, nonatomic) UIButton* menuItemButton3;
@property(strong, nonatomic) UIButton* menuItemButton4;
@property(strong, nonatomic) UIButton* menuItemButton5;
@property(strong, nonatomic) UIButton* goToCheckButtonIntro;
@property(strong, nonatomic) UIButton* goToCheckButton;
@property(strong, nonatomic) UIButton* goToAddMenuButton;
@property(strong, nonatomic) UIButton* menuButton;

@property UIScrollView* menuView;//UIView* menuView;
@property UIView* baseView;
@property UIView* menuItem0;
@property UIView* menuItem1;
@property UIView* menuItem2;
@property UIView* menuItem3;
@property UIView* menuItem4;
@property UIView* menuItem5;
@property UIView* goToCheckButtonView;
@property UIView* goToAddMenuButtonView;



@property(nonatomic) int screenW;
@property(nonatomic) int screenH;
@property(nonatomic) int menuIndex;
@property(nonatomic) int addIndex;
@property(nonatomic) int CheckBeginIndex;
@property(nonatomic) int NumberOfCheck;

@property(strong, nonatomic) MainView* mainView;
@property(strong, nonatomic) CheckView* checkView;
@property(strong, nonatomic) inviteView* inviteView;
@property(strong, nonatomic) UIImageView* imgView;
@property(strong, nonatomic) PurchaseView* purchaseView;

@end
