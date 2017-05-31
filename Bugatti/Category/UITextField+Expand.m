//
//  UITextField+Expand.m
//  A02_iPhone
//
//  Created by toby on 11/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "UITextField+Expand.h"

@implementation UITextField (Expand)

- (BOOL) deptNameInputShouldChinese
{
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self.text]) {
        return YES;
    }
    return NO;
}

@end
