//
//  UserManager.m
//  Bugatti
//
//  Created by moses on 5/31/17.
//  Copyright © 2017 toby. All rights reserved.
//

#import "UserInfo.h"

@interface UserInfo()


@property (nonatomic,strong) NSMutableArray *userBehaviors;
@end

@implementation UserInfo{
    
    //用户行为统计
    NSMutableDictionary * _behaviorDict;
    NSInteger _dataLength;
}

#pragma mark - 公开接口

- (void)collectUserBehaviorWithData:(NSDictionary *)data{
    
    if(data){
        [self.userBehaviors addObject:data];
    }
    
    
#warning 这里在 baseTabBarController做了 KVO
//    所以dataLength每次变化都会被监听，后期可以考虑优化
    //比如如果10k发送一次行为数据的话 每次行为数据大概 30byte    10k／30b = 340
    
    self.dataLength += [self convertToJsonData:data].length;
    NSLog(@"collectUserBehaviorWithData:%@  dataLength:%ld",self.behaviorDict,self.dataLength);
    
}

- (void)resetUserBehavior{
    self.userBehaviors = nil;
    _behaviorDict = nil;
    _dataLength = 0;
}

#pragma mark - 私有接口

// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

//JSON字符串转化为字典

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark - set get



- (NSMutableArray *)userBehaviors{
    if(!_userBehaviors){
        _userBehaviors = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _userBehaviors;
}

/*{@"user_id"    :"lucy",
 @"behavior": [
 
 {@"func_id"   :1
 @"begin_time": 2017.6.5 18:35:20
 @"duration"  : 88
 },
 
 {@"f"   : 1
 @"b"    : 2017.6.5 18:35:20
 @"d"    : 88
 },
 ]
 };
 */
- (NSMutableDictionary *)behaviorDict{
    if(!_behaviorDict){
        _behaviorDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    
#warning user_id为测试
    [_behaviorDict setObject:@"10002" forKey:@"u"];
    [_behaviorDict setObject:self.userBehaviors forKey:@"b"];
    
    return _behaviorDict;
}

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

static UserInfo * _instance = nil;

+ (instancetype)shareManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [UserInfo shareManager] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [UserInfo shareManager] ;
}

@end
