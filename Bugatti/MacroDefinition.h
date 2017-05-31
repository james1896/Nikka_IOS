//
//  MacroDefinition_h.m
//  Bugatti
//
//  Created by toby on 09/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//


// 定义弱引用
#define weakSelf(weakSelf) __weak __typeof(&*self) weakSelf = self;


//-------------------   UI  -------------------------

#define VIEW_PACE 18
#define LEFT_EGDE 33

//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT 44
#define STATUS_NAVBAR_HEIGHT 64

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define CONTENT_HEIGHT ([UIScreen mainScreen].bounds.size.height) - 48



//----------------------系统----------------------------

#define APP_FONT(fontSize)      [UIFont fontWithName:@"Marker Felt" size:fontSize];

#define IS_IPHONE5          self.view.frame.size.height == 568
#define IS_IPHONE7          self.view.frame.size.height == 667
#define IS_IPHONE7PLUS      self.view.frame.size.height == 736

//获取系统版本
#define IOS_VERSION             [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IOS8_LATER           ([[[UIDevice currentDevice] systemVersion] floatValue] > 8)
#define IS_IOS10_LATER           ([[[UIDevice currentDevice] systemVersion] floatValue] > 10)

#define CurrentSystemVersion ［[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), ［UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), ［UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断设备的操做系统是不是ios7
#define IOS7 (［[UIDevice currentDevice].systemVersion doubleValue] >= 7.0]

//判断当前设备是不是iphone5
#define kScreenIphone5 ((［UIScreen mainScreen] bounds].size.height)>=568)

//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer］
//建议使用前两种宏定义,性能高于后者


//----------------------颜色类---------------------------

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//----------------------颜色类--------------------------
