//
//  UserManager.h
//  Bugatti
//
//  Created by moses on 5/31/17.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject{
    CGFloat _moneyPoints;
    NSString *_password;
    NSString *_user_id;
    NSString *_userName;
    NSString *_userToken;
    NSString *_userPhone;
}


@property (nonatomic,readonly)              BOOL isLogin;

/**
 用户用户名 密码 用户token
 */
@property (nonatomic,copy)          NSString *userName;
@property (nonatomic,copy)          NSString *user_id;
@property (nonatomic,copy)          NSString *userToken;
@property (nonatomic,copy)          NSString *password;
@property (nonatomic)               CGFloat   moneyPoints;

@property (nonatomic,copy)          NSString *userPhone;



+ (instancetype)shareManager;

@end
