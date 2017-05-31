//
//  NetTypeDelegate.h
//  Bugatti
//
//  Created by toby on 29/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetTypeDelegate <NSObject>

- (void)netTypeStatusReachableWIFI;
- (void)netTypeStatusReachableWWAN;
- (void)netTypeStatusNotReachable;
- (void)netTypeStatusUnknown;
@end
