//
//  AppDelegate.h
//  mikanDev
//
//  Created by Shun Usami on 2014/06/04.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyStoreObserver.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyStoreObserver *mySKObserver;

@end
