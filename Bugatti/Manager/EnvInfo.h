//
//  EnvInfo.h
//  Bugatti
//
//  Created by toby on 07/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
   
    NKNetWorkTypeStatusUnknown = 0, //未知
    NKNetWorkTypeNotReachable,      //无网络
    NKNetWorkTypeWIFI ,             //wifi
    NKNetWorkTypeWWAN               //手机网络
    
}   NKNetWorkType;

static int byte_1_K = 1 * 1024; //(1K)
static int byte_10_K = 10 * 1024; //(10K)
static int byte_512_K = 512 * 1024; //(0.5M)

static int byte_1_M = 1024 * 1024; //(1M)



@interface EnvInfo : NSObject

@property(nonatomic) NKNetWorkType netWorkType;

//app版本
@property (nonatomic,strong,readonly) NSString *version;

@end
