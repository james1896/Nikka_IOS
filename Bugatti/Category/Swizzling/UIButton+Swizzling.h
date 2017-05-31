//
//  UIButton+Swizzling.h
//  RuntimeTest
//
//  Created by toby on 20/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval 0.5  //默认时间间隔

@interface UIButton (Swizzling)

 @property (nonatomic, assign) NSTimeInterval timeInterval;

@end
