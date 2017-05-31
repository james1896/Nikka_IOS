//
//  UILabel+nikka.m
//  Bugatti
//
//  Created by toby on 17/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "UILabel+nikka.h"

@implementation UILabel (nikka)


- (void)textSizeTofit{
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    // ceilf()向上取整函数, 只要大于1就取整数2. floor()向下取整函数, 只要小于2就取整数1.
    size = CGSizeMake(ceilf(size.width), ceilf(size.height));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}
@end
