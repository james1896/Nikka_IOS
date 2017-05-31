//
//  userDataManager.m
//  Bugatti
//
//  Created by toby on 11/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "UserDataManager.h"
#import "TBKeyChain.h"
static UserDataManager* _instance = nil;

@interface UserDataManager()
@property (nonatomic,readwrite)              BOOL isLogin;
@end


@implementation UserDataManager

- (void)loginSuccessedWithUserName:(NSString *)name pwd:(NSString *)password user_id:(NSString *)user_id points:(CGFloat)points{
    
    [self saveObject:name       forKey:@"NIKKA_SAVEUSERNAME"];
    [self saveObject:password   forKey:@"NIKKA_SAVEPASSWORD"];
    [self saveObject:user_id    forKey:@"NIKKA_SAVEUSERID"];
//    self.moneyPoints = points;
    [[NSUserDefaults standardUserDefaults] setFloat:points forKey:@"NIKKA_POINTS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)resetUserData{
//    self.moneyPoints = NULL;
    [self saveObject:NULL       forKey:@"NIKKA_SAVEUSERNAME"];
    [self saveObject:NULL forKey:@"NIKKA_SAVEUSERID"];
    [self saveObject:NULL   forKey:@"NIKKA_SAVEPASSWORD"];
    self.moneyPoints = 0;
    
    NSLog(@"username:%@ password:%@ points:%f",self.userName,self.password,self.moneyPoints);
}

- (void)saveObject:(id)obj forKey:(NSString *)key{

          [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     SET GET 方法      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark SET GET 方法

- (UserManager *)userManager{
    if(!_userManager){
        _userManager = [[UserManager alloc]init];
    }
    return _userManager;
}

- (DeviceInfo *)deviceInfo{
    
    if(!_deviceInfo){
        _deviceInfo = [[DeviceInfo alloc] init];
    }
    
    return _deviceInfo;
}

- (NotificationManager *)notificationManager{
    if(!_notificationManager){
        _notificationManager = [[NotificationManager alloc]init];
    }
    return _notificationManager;
}

- (BOOL)isLogin{
    
    return (self.userName != NULL && self.password != NULL);
    return YES;
}

- (void)setUserInfo_request_time:(double)userInfo_request_time{
    _userInfo_request_time = userInfo_request_time;
    [[NSUserDefaults standardUserDefaults] setDouble:userInfo_request_time forKey:@"NIKKA_userInfo_request_time"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (double)userInfo_request_time{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"NIKKA_userInfo_request_time"];
}


/* 转移到 userManager */
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

/* 转移到 userManager */

/*  ~~~~~~~~~~~~~~~~~~~~~~~     单例      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark lift cycle

+ (instancetype)shareManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [UserDataManager shareManager] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [UserDataManager shareManager] ;
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     异步串行队列     ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark 异步串行队列

- (void)asyncSerialQueue:(void (^)())task success:(void (^)())success{
    dispatch_async(dispatch_queue_create("com.SERIAL.gcdDemo", DISPATCH_QUEUE_SERIAL), ^{
        task();
        dispatch_async(dispatch_get_main_queue(), ^{
            success();
        });
    });
}



    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////


- (void)semaphore{
        dispatch_group_t group = dispatch_group_create();
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
        dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        for (int i =0; i<9;i++){
            NSLog(@"for:%i",i);
    
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_group_async(group, queue, ^{
                NSLog(@"log:%i",i);
                sleep(2);
                dispatch_semaphore_signal(semaphore);
            });
        }
        NSLog(@"end1");
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //    NSLog(@"end2");
    
        dispatch_group_notify(group, queue, ^{
            NSLog(@"end2");
        });
        
        NSLog(@"do some");
}

- (void)gcdgroup{
    dispatch_group_t group = dispatch_group_create();
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_CONCURRENT);
    for (int i =0; i<9;i++){
        NSLog(@"for:%i",i);
        
        //        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            
            int flog = random()%10;
            sleep(2*flog);
            NSLog(@"log:%i  sleep:%i",i,2*flog);
            //            dispatch_semaphore_signal(semaphore);
        });
    }
    NSLog(@"end1");
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //    NSLog(@"end2");
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"end2");
    });
    
    NSLog(@"do some");
}

+ (NSTimeInterval)getCurrentTime{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    return time;
}
//- (void)asyncConcurrentQueue:(void (^)())task success:(void (^)())success{
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_CONCURRENT);
////    for (int i =0; i<9;i++){
////        NSLog(@"for:%i",i);
////        dispatch_group_async(group, queue, ^{
////            
////            int flog = random()%10;
////            sleep(2*flog);
////            NSLog(@"log:%i  sleep:%i",i,2*flog);
////        });
////    }
////    NSLog(@"end1");
////    dispatch_group_notify(group, queue, ^{
////        NSLog(@"end2");
////        success();
////    });
//    
//    dispatch_async(queue, ^{
//        task();
//        dispatch_async(dispatch_get_main_queue(), ^{
//            success();
//        });
//    });
//
//}
//
//- (void)asyncConcurrentQueue:(void (^)())task, ...{
//
//}
@end

@implementation DeviceInfo

- (CGFloat)currentScreenLight{
    return  [[UIScreen mainScreen] brightness];
}

- (void)setScreenBrightness:(CGFloat)value{
    
    CGFloat tmpLight = self.currentScreenLight;
    
    //调节亮暗因子
    int flog = 1000;
    
    if(value > tmpLight){
        //调亮
        for(int i=0 ;i<flog;i++){
            CGFloat tmp = (0.99-tmpLight)/flog;
            NSLog(@"i:%d",i);
            tmpLight += tmp;
            [[UIScreen mainScreen] setBrightness: tmpLight];
        }
    }else{
        //调暗
        for(int i=flog/3;i>0;i--){
            CGFloat tmp = (tmpLight -value)/(flog/3);
            NSLog(@"i:%d",i);
            tmpLight -= tmp;
            [[UIScreen mainScreen] setBrightness: tmpLight];
        }
    }
    
    
}

- (NSString *)getUUID
{
    NSString * strUUID = (NSString *)[TBKeyChain load:@"com.company.app.usernamepassword"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [TBKeyChain save:@"com.company.app.usernamepassword" data:strUUID];
        
    }
    return strUUID;
}
@end
