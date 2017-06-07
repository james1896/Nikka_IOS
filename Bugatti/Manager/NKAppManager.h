//
//  userDataManager.h
//  Bugatti
//
//  Created by toby on 11/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EnvInfo.h"
#import "UserInfo.h"
#import "DeviceInfo.h"

#import "NotificationManager.h"


@interface NKAppManager : NSObject{
    double _userInfo_request_time;
    
    
    CGFloat _moneyPoints;
    NSString *_password;
    NSString *_user_id;
    NSString *_userName;
    NSString *_userToken;
    NSString *_userPhone;
    UserInfo *_userManager;
}

+ (instancetype)shareManager;

@property (nonatomic,readonly)  BOOL isLogin;


//app环境信息
@property (nonatomic,strong) EnvInfo *envInfo;
//设备信息
@property (nonatomic,strong) DeviceInfo *deviceInfo;
//用户数据
@property (nonatomic,strong,readonly) UserInfo *userInfo;


//userinfo 请求成功的时间
@property (nonatomic) double userInfo_request_time;

@property (nonatomic,strong)   NotificationManager *notificationManager;

//初始化 用户信息
- (void)resetUserInfo;

//异步串行队列
- (void)asyncSerialQueue:(void(^)())task success:(void(^)())success;
//- (void)asyncConcurrentQueue:(void(^)())task  success:(void(^)())success;
//
//- (void)asyncConcurrentQueue:(void(^)())task , ...NS_REQUIRES_NIL_TERMINATION;

- (void)semaphore;
- (void)gcdgroup;

@end
