//
//  MyStoreObserver.h
//  mikanDev
//
//  Created by Shun Usami on 2014/06/13.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "Common.h"

@protocol MyStoreObserverDelegate;

@interface MyStoreObserver : NSObject <SKPaymentTransactionObserver> {
}
@property (nonatomic, assign) id<MyStoreObserverDelegate> delegate;

@end

@protocol MyStoreObserverDelegate <NSObject>
@optional
- (void)ShowActivityIndicator;
- (void)hideActivityIndicator;
@end