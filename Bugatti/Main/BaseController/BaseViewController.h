//
//  BaseViewController.h
//  Bugatti
//
//  Created by toby on 09/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeSprite.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

@class UserInfo,NKAppManager;

typedef enum {
    NavTitleAlignmentLeft,
    NavTitleAlignmentLeftEdge,
    NavTitleAlignmentCenter
    
}NavTitleAlignment;
@interface BaseViewController : UIViewController

@property (nonatomic,strong) ThemeSprite    *sprite;

@property (nonatomic,strong) NKAppManager *dataManager;
@property (nonatomic,strong) UserInfo *userInfo;



@property (nonatomic,copy) NSString         *titleName;
@property (nonatomic,copy) NSString         *subtitleName;

//页面ID 用户行为统计使用
@property (nonatomic,readonly) NSInteger pageID;

@property (nonatomic,strong) UIColor        *titleColor;
@property (nonatomic) NavTitleAlignment     titleAlignment;

@property (nonatomic,strong) UIColor *navbarBackgroundColor;

@property (nonatomic,strong) UIImage    *backgroundImage;


- (void)navbarPress;
- (void)addWhiteBackbutton;
- (void)addGrayBackbutton;
- (void)addPinkBackbutton;

@end

@interface UIViewController(UIViewControllerItem)

@property(nullable, nonatomic,readonly,strong) BaseTabBarController *baseTabbarController;
@property(nullable, nonatomic,readonly,strong) BaseNavigationController *baseNavigationController;

@end
