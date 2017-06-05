//
//  userDataManager.h
//  Bugatti
//
//  Created by toby on 11/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NotificationManager.h"
#import "UserManager.h"

@class DeviceInfo;

@interface UserDataManager : NSObject{
    double _userInfo_request_time;
    
    
    CGFloat _moneyPoints;
    NSString *_password;
    NSString *_user_id;
    NSString *_userName;
    NSString *_userToken;
    NSString *_userPhone;
    UserManager *_userManager;
}



@property (nonatomic,strong) DeviceInfo *deviceInfo;

@property (nonatomic,strong,readonly) UserManager *userManager;

@property (nonatomic,readonly)              BOOL isLogin;

///**
// 用户用户名 密码 用户token
// */
//@property (nonatomic,copy)          NSString *userName;
//@property (nonatomic,copy)          NSString *user_id;
//@property (nonatomic,copy)          NSString *userToken;
//@property (nonatomic,copy)          NSString *password;
//@property (nonatomic,copy)          NSString *userPhone;
//@property (nonatomic)               CGFloat   moneyPoints;


//userinfo 请求成功的时间
@property (nonatomic) double userInfo_request_time;

@property (nonatomic,strong)                NotificationManager *notificationManager;

- (void)loginSuccessedWithUserName:(NSString *)name pwd:(NSString *)password user_id:(NSString *)user_id points:(CGFloat)points;
- (void)resetUserData;

//异步串行队列
- (void)asyncSerialQueue:(void(^)())task success:(void(^)())success;
//- (void)asyncConcurrentQueue:(void(^)())task  success:(void(^)())success;
//
//- (void)asyncConcurrentQueue:(void(^)())task , ...NS_REQUIRES_NIL_TERMINATION;

- (void)semaphore;
- (void)gcdgroup;
+ (instancetype)shareManager;

+ (NSTimeInterval)getCurrentTime;
@end


@interface DeviceInfo : NSObject


//调节屏幕亮暗
//这个值介于0和1之间
@property (nonatomic,readonly) CGFloat currentScreenLight;
- (void)setScreenBrightness:(CGFloat)value;

//获得ip地址
- (NSString *)getIPAddress:(BOOL)preferIPv4;
//获得uuid
- (NSString *)getUUID;

@end
