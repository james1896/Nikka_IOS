//
//  AppDelegate.m
//  Bugatti
//
//  Created by toby on 06/02/2017.
//  Copyright © 2017 toby. All rights reserved.

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ////////////////////////////////////////////////////////////////////////////
    
    
    //远程推送
    
    [[[UserDataManager shareManager] notificationManager] registerRemoteNotification];
    ///////////////////////////////////////////////////////////////////////////////////
    //本地推送
    
        
    ///////////////////////////////////////////////////////////////////////////////////
    
    //在App没有运行的情况下，系统收到推送消息，用户点击推送消息
    NSDictionary *userInfo =[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"userInfo:%@",userInfo);
    //    NSLog(@"在App没有运行的情况下，系统收到推送消息，用户点击推送消息 : %@",userInfo);
    [[UserDataManager shareManager] notificationManager].notificationType = NotificationManagerTypeRemoteNotificationOnExit;
    [[[UserDataManager shareManager] notificationManager] handleNotificationUserInfo:userInfo];
    
   
    return YES;
}


//App启动过程中，使用UIApplication::registerForRemoteNotificationTypes函数与苹果的APNS服务器通信，发出注册远程推送的申请。
//若注册成功，回调函数application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 会被触发，App可以得到deviceToken，

//该token就是一个与设备相关的字符串.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    

    [[[UserDataManager shareManager] notificationManager] saveRemoteNotificationDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"%@",NSStringFromSelector(_cmd));
//    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"PUSH error:%@",error);
    
}

//当APP处于前台时，系统收到推送消息，此时系统不会弹出消息提示，会直接触发

//当App处于后台时，如果系统收到推送消息，当用户点击推送消息时
//此时AppDelegate中函数执行的顺序为：
//applicationWillEnterForeground
//application:didReceiveRemoteNotification
//applicationDidBecomeActive
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"当APP处于前台时，系统收到推送消息，此时系统不会弹出消息提示，会直接触发 : %@",userInfo);
    [[UserDataManager shareManager] notificationManager].notificationType = NotificationManagerTypeRemoteNotificationOnActive;
    [[[UserDataManager shareManager] notificationManager] handleNotificationUserInfo:userInfo];
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 监控键盘
 */
- (void)monitorKeyword{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

@end
