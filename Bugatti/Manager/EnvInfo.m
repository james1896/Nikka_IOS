//
//  EnvInfo.m
//  Bugatti
//
//  Created by toby on 07/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "EnvInfo.h"
#import "AFNetworkReachabilityManager.h"


@implementation EnvInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //AFNetworking 检测网络变化
        //    self.manager = [AFNetworkReachabilityManager sharedManager];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //当网络状态发生变化时会调用这个block
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    NSLog(@"WiFi");
                    [NKAppManager shareManager].envInfo.netWorkType = NKNetWorkTypeWIFI;
                    break;
                }
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"手机网络");
                    [NKAppManager shareManager].envInfo.netWorkType = NKNetWorkTypeWWAN;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"没有网络");
                    [NKAppManager shareManager].envInfo.netWorkType = NKNetWorkTypeNotReachable;
                    break;
                case AFNetworkReachabilityStatusUnknown:
                    NSLog(@"未知网络");
                    [NKAppManager shareManager].envInfo.netWorkType = NKNetWorkTypeStatusUnknown;
                    break;
                    
                default:
                    break;
            }
        }];
        [manager startMonitoring];

    }
    return self;
}

- (void)dealloc
{
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (NSString *)version{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
