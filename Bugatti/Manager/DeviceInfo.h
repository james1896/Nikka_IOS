//
//  DeviceInfo.h
//  Bugatti
//
//  Created by toby on 07/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

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
