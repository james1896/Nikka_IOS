//
//  UIButton+NIKButton.m
//  Bugatti
//
//  Created by toby on 05/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "UIButton+NIKButton.h"

@implementation UIButton (NIKButton)

+ (UIButton *)createWhiteBackButtonWithTarget:(id)target action:(SEL)action{
    UIButton *button = [self createButtonWithBackgroundimage:[UIImage imageNamed:@"back_white"]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createGrayBackButtonWithTarget:(id)target action:(SEL)action{
    UIButton *button = [self createButtonWithBackgroundimage:[UIImage imageNamed:@"back_gray"]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createPinkBackButtonWithTarget:(id)target action:(SEL)action{
    UIButton *button = [self createButtonWithBackgroundimage:[UIImage imageNamed:@"back_pink"]];
     [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createButtonWithBackgroundimage:(UIImage *)backgroundimage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(VIEW_PACE, SCREEN_HEIGHT-40, 26, 26);
    [button setBackgroundImage:backgroundimage forState:UIControlStateNormal];
    return button;
}
@end
