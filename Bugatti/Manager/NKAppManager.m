//
//  userDataManager.m
//  Bugatti
//
//  Created by toby on 11/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "NKAppManager.h"

static NKAppManager* _instance = nil;

@interface NKAppManager()
@property (nonatomic,readwrite)              BOOL isLogin;
@end


@implementation NKAppManager


- (void)resetUserInfo{
    [self saveObject:NULL       forKey:@"NIKKA_SAVEUSERNAME"];
    [self saveObject:NULL forKey:@"NIKKA_SAVEUSERID"];
    [self saveObject:NULL   forKey:@"NIKKA_SAVEPASSWORD"];
    self.userInfo.moneyPoints = 0;
    
//    NSLog(@"username:%@ password:%@ points:%f",self.userName,self.password,self.moneyPoints);
}

- (void)saveObject:(id)obj forKey:(NSString *)key{

          [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     SET GET 方法      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark SET GET 方法

- (EnvInfo *)envInfo{
    if(!_envInfo){
        _envInfo = [[EnvInfo alloc]init];
    }
    return _envInfo;
}

- (UserInfo *)userInfo{
    if(!_userManager){
        _userManager = [[UserInfo alloc]init];
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
    
    return (self.userInfo.userName != NULL && self.userInfo.password != NULL);
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




/*  ~~~~~~~~~~~~~~~~~~~~~~~     单例      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark lift cycle

+ (instancetype)shareManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
        _instance.envInfo = [[EnvInfo alloc]init];
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [NKAppManager shareManager] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [NKAppManager shareManager] ;
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

