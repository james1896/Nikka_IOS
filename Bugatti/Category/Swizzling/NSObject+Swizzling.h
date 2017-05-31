//
//  NSObject+Swizzling.h
//  RuntimeTest
//
//  Created by toby on 20/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end
