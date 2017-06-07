//
//  UserManager.h
//  Bugatti
//
//  Created by moses on 5/31/17.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject{
    CGFloat _moneyPoints;
    NSString *_password;
    NSString *_user_id;
    NSString *_userName;
    NSString *_userToken;
    NSString *_userPhone;
}

+ (instancetype)shareUserInfo;
@property (nonatomic,readonly)   BOOL isLogin;

/**
 用户用户名 密码 用户token
 */
@property (nonatomic,copy)          NSString *userName;
@property (nonatomic,copy)          NSString *user_id;
@property (nonatomic,copy)          NSString *userToken;
@property (nonatomic,copy)          NSString *password;
@property (nonatomic)               CGFloat   moneyPoints;

@property (nonatomic,copy)          NSString *userPhone;


//用户行为统计
//用户行为收集

- (void)saveUserBehavior;
- (void)resetUserBehavior;
- (void)collectUserBehaviorWithData:(NSDictionary *)data;
@property (nonatomic) NSInteger dataLength;

@property (nonatomic,strong,readonly) NSString *behaviorStr;
@end
