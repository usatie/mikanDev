//
//  MyStoreObserver.m
//  mikanDev
//
//  Created by Shun Usami on 2014/06/13.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "MyStoreObserver.h"

@implementation MyStoreObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                // 購入処理中。基本、何もしなくて良い。
                //[self ShowActivityIndicatorDelegate];
                break;
            case SKPaymentTransactionStatePurchased:
                // 購入処理成功
                // アイテムの再付与を行う
            {NSLog(@"completeTransaction! make item");
                [self hideActivityIndicatorDelegate];
                NSString *strID = transaction.payment.productIdentifier;
                NSLog(@"strID:%@",strID);
                [self purchaseCompleted:transaction];
                //[self completeTransaction:transaction];
                [queue finishTransaction:transaction];
            break;}
            case SKPaymentTransactionStateFailed:
                // 購入処理エラー。ユーザが購入処理をキャンセルした場合もここにくる
                // エラーが発生したことをユーザに知らせる
                // [self failedTransaction:transaction];
                if (transaction.error.code != SKErrorPaymentCancelled){
                    NSLog(@"failedTransaction error");
                } else {
                    NSLog(@"failedTransaction cancel");
                }
                [self hideActivityIndicatorDelegate];
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                // リストア処理完了
                // アイテムの再付与を行う
                // [self restoreTransaction:transaction];
                [queue finishTransaction:transaction];
                break;
            default:
                break;
        } }
}
// 購入処理の終了
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
     NSLog(@"paymentQueue:removedTransactions -- all end --");
}

- (void)purchaseCompleted:(SKPaymentTransaction *)transaction
{
    NSLog(@"purchaseCompleted");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //[userDefaults integerForKey:@"TheNumberOfMikans"]
    if ([transaction.payment.productIdentifier isEqualToString:@"link.mikan.mikanDev.consumable_test1"]) {
//        _consumableCount ++;
//        _countLabel.text = [NSString stringWithFormat:@"%d", _consumableCount];
        [userDefaults setInteger:[userDefaults integerForKey:@"TheNumberOfMikans"]+1 forKey:@"TheNumberOfMikans"];
    }
    //non-consumable なら enabled にする
    else if ([transaction.payment.productIdentifier isEqualToString:@"link.mikan.mikanDev.consumable_test2"]){
        [userDefaults setInteger:[userDefaults integerForKey:@"TheNumberOfMikans"]+6 forKey:@"TheNumberOfMikans"];
    }
    [userDefaults synchronize];
}

- (void)ShowActivityIndicatorDelegate
{
    if ([_delegate respondsToSelector:@selector(ShowActivityIndicator)]) {
        [_delegate ShowActivityIndicator];
    } else NSLog(@"no responds to showActivityIndicator");
}

- (void)hideActivityIndicatorDelegate
{
    if ([_delegate respondsToSelector:@selector(hideActivityIndicator)]) {
        [_delegate hideActivityIndicator];
    } else NSLog(@"no responds to hideActivityIndicator");
}

@end