//
//  UserManager.m
//  Bugatti
//
//  Created by moses on 5/31/17.
//  Copyright © 2017 toby. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager



- (void)setUserToken:(NSString *)userToken{
    _userToken = userToken;
    [self saveObject:userToken forKey:@"NIKKA_SAVEUSERTOKEN"];
}

- (NSString *)userToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"NIKKA_SAVEUSERTOKEN"];
}

- (void)setUserName:(NSString *)userName{
    _userName = userName;
    [self saveObject:userName forKey:@"NIKKA_SAVEUSERNAME"];
}

- (NSString *)userName{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"NIKKA_SAVEUSERNAME"];
}

- (void)setUser_id:(NSString *)user_id{
    _user_id = user_id;
    [self saveObject:user_id forKey:@"NIKKA_SAVEUSERID"];
}
- (NSString *)user_id{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"NIKKA_SAVEUSERID"];
}

- (void)setPassword:(NSString *)password{
    _password = password;
    [self saveObject:password   forKey:@"NIKKA_SAVEPASSWORD"];
}

- (NSString *)password{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"NIKKA_SAVEPASSWORD"];
}

- (void)setMoneyPoints:(CGFloat)moneyPoints{
    _moneyPoints = moneyPoints;
    [[NSUserDefaults standardUserDefaults] setFloat:moneyPoints forKey:@"NIKKA_POINTS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (CGFloat)moneyPoints{
    
    CGFloat f = [[NSUserDefaults standardUserDefaults] floatForKey:@"NIKKA_POINTS"];
    if(!f){
        return 0.0f;
    }
    return f;
}


- (void)saveObject:(id)obj forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     单例      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark lift cycle

static UserManager * _instance = nil;

+ (instancetype)shareManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [UserManager shareManager] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [UserManager shareManager] ;
}

@end
