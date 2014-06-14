//
//  AppDelegate.m
//  mikanDev
//
//  Created by Shun Usami on 2014/06/04.
//  Copyright (c) 2014年 ShunUsami. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <NCMB/NCMB.h>
//#import "Common.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // ここでスレッドを止める
    [NSThread sleepForTimeInterval:1.0];
    //nifty cloud mobile
    [NCMB setApplicationKey:@"752df961e7eebdae823cbc8f6175ea4005f8e04539c10414d85a967c8e822158" clientKey:@"e55a5c07f0b68dd7012af01e9f20c32a6625ccf2009f004042b0487b8bbdbdee"];
    // Activate Push Notification
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[ViewController alloc] init];
//    PurchaseViewController* purchaseViewController = [[PurchaseViewController alloc] init];
//    [self.window addSubview:purchaseViewController.view];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Helvetica" size:18.0f]];
    
    [self.window makeKeyAndVisible];
    //[self testDownloadFileWithFileName];
    
    
    // アプリ内課金
	mySKObserver = [[MyStoreObserver alloc] init];
	[[SKPaymentQueue defaultQueue] addTransactionObserver: mySKObserver];
    
	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:app];
    
    
    
    return YES;
}

- (void) testDownloadFileWithFileName {
    NCMBFile *fileData = [NCMBFile fileWithName:@"test.png" data:nil];
    [fileData getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error){
            UIImage *image = [[UIImage alloc] initWithData:data];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:imageView];
            NSLog(@"ok");
        } else {
            NSLog(@"error:%@",error);
        }
    }];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NCMBInstallation *currentInstallation = [NCMBInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation save];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[SKPaymentQueue defaultQueue] removeTransactionObserver: mySKObserver];
}

@end
