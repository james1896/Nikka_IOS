//
//  BaseTabBarController.h
//  Bugatti
//
//  Created by toby on 16/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController


- (void)showLoginController;

/**
 显示某个 controller之前 
 需要先判断用户是否登录

 @param controller 希望打开的controller
 */
- (void)showLoginControllerWithDesiredController:(UIViewController *)controller;
@end
