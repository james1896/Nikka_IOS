//
//  UIButton+NIKButton.h
//  Bugatti
//
//  Created by toby on 05/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (NIKButton)

+ (UIButton *)createWhiteBackButtonWithTarget:(id)target action:(SEL)action;
+ (UIButton *)createGrayBackButtonWithTarget:(id)target action:(SEL)action;
+ (UIButton *)createPinkBackButtonWithTarget:(id)target action:(SEL)action;
@end
