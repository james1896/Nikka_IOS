//
//  BaseTabBarController.m
//  Bugatti
//
//  Created by toby on 16/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TBLoginViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "LocalAuthentication/LocalAuthentication.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate,TBLoginViewControllerDelegate>

@property (nonatomic,strong) TBLoginViewController *login;

@property (nonatomic,strong) UIViewController *desiredController;
//@property (nonatomic,strong) AFNetworkReachabilityManager *manager;

@end

@implementation BaseTabBarController

- (TBLoginViewController *)login{
    if(!_login){
        _login = [[TBLoginViewController alloc]init];
        _login.delegate = self;
    }
    return _login;
}


#pragma mark - 公开方法

- (void)showLoginController{
    
    [self presentViewController:self.login animated:YES completion:^{
        
    }];
}

- (void)showLoginControllerWithDesiredController:(UIViewController *)controller{
    self.desiredController = nil;
    
    if([UserDataManager shareManager].isLogin){
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        self.desiredController = controller;
        [self presentViewController:self.login animated:YES completion:^{
            
        }];
    }
}

#pragma mark - TBLoginViewControllerDelegate

- (void)loginSuccessedController:(TBLoginViewController *)login{
    
    if(self.desiredController){
        [self.navigationController pushViewController:self.desiredController animated:NO];
    }
    
    [login dismissViewControllerAnimated:YES completion:^{
    
    }];
}



#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

//    NSLog(@"baseTabbarController:%@",tabBarController.navigationController);
    return YES;
}
/*  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 指纹识别    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark - 指纹识别
- (void)touchID{
    LAContext *context = [LAContext new]; //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"没有忘记密码";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                             error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        NSLog(@"验证成功 刷新主界面");
                      
                    }else{
                        NSLog(@"%@",error.localizedDescription);
                        switch (error.code) {
                            case LAErrorSystemCancel:
                            {
                                NSLog(@"系统取消授权，如其他APP切入");
                                break;
                            }
                            case LAErrorUserCancel:
                            {
                                NSLog(@"用户取消验证Touch ID");
                                break;
                            }
                            case LAErrorAuthenticationFailed:
                            {
                                NSLog(@"授权失败");
                                break;
                            }
                            case LAErrorPasscodeNotSet:
                            {
                                NSLog(@"系统未设置密码");
                                break;
                            }
                            case LAErrorTouchIDNotAvailable:
                            {
                                NSLog(@"设备Touch ID不可用，例如未打开");
                                break;
                            }
                            case LAErrorTouchIDNotEnrolled:
                            {
                                NSLog(@"设备Touch ID不可用，用户未录入");
                                break;
                            }
                            case LAErrorUserFallback:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"用户选择输入密码，切换主线程处理");
                                }];
                                break;
                            }
                            default:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"其他情况，切换主线程处理");
                                }];
                                break;
                            }
                        }
                    }
                }];
    }else{
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                //指纹功能没有开启
                NSLog(@"TouchID is not enrolled");
              
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     lift cycle      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark - lift cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + 5)];
        [imageView setImage:[self createImageWithColor:[UIColor clearColor]]];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        [self.tabBar insertSubview:imageView atIndex:0];
        //覆盖原生Tabbar的上横线
        [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
        //背景图片为透明色
        [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
        self.tabBar.backgroundColor = [UIColor clearColor];
        //设置为半透明
//        self.tabBarController.tabBar.translucent = YES;
        
        self.tabBar.tintColor = [UIColor blackColor];
        // 字体颜色 选中
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
        
        // 字体颜色 未选中
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];

        
        //
        
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"version:%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]);
//    这里需要添加version字段
    if([APPUtils isIntradayWithLastTime:[[NSUserDefaults standardUserDefaults]
                                         doubleForKey:NIKKA_USERINFO_REQUEST_TIME]]){
    
        
        [TBRuquestManager userInfoWithUUID:[[UserDataManager shareManager].deviceInfo getUUID]
                                    device:[APPUtils getDeviceModel]
                                  lastTime:@""
                                  userName:[UserDataManager shareManager].userManager.userName
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       
                                       
                                       [APPUtils cuurentTimeWithTag:NIKKA_USERINFO_REQUEST_TIME];
                                       
                                   }
                                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       
                                   }];
    }
    
    
    
    //AFNetworking 检测网络变化
//    self.manager = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //当网络状态发生变化时会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
    
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
