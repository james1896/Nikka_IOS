//
//  BaseTabBarController.m
//  Bugatti
//
//  Created by toby on 16/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TBLoginViewController.h"
#import "AFHTTPSessionManager.h"


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
    
    if([NKAppManager shareManager].isLogin){
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
    
   
#warning   这里需要添加version字段
    if([APPUtils isIntradayWithLastTime:[[NSUserDefaults standardUserDefaults]
                                         doubleForKey:NIKKA_USERINFO_REQUEST_TIME]]){
    
        
        [TBRuquestManager userInfoWithUUID:[[NKAppManager shareManager].deviceInfo getUUID]
                                    device:[APPUtils getDeviceModel]
                                  lastTime:@""
                                  userName:[NKAppManager shareManager].userInfo.userName
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       
                                       
                                       [APPUtils cuurentTimeWithTag:NIKKA_USERINFO_REQUEST_TIME];
                                       
                                   }
                                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       
                                   }];
    }
    
    [[NKAppManager shareManager].userInfo addObserver:self forKeyPath:@"dataLength" options:NSKeyValueObservingOptionNew context:nil] ;
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
//    NSLog(@"keyPath:%@ object:%@ change：%@ context：%@",keyPath,object,change,context);
    //观察 dataLength 值
    //datalength 用于用户数据发送
    if([keyPath isEqualToString:@"dataLength"]){
        UserInfo *userInfo = (UserInfo *)object;
        
        //    用户行为数据  只有 wifi环境下才发送数据
        if (userInfo.dataLength > byte_10_K && [NKAppManager shareManager].envInfo.netWorkType == NKNetWorkTypeWIFI){
            //每次操作大概消耗 30个byte 10k大概操作 340次
            NSLog(@"用户行为数据达到10k 请求发送数据:%ld",userInfo.dataLength);
            
            //发送成功 清空
//            if(1){
//                [[NKAppManager shareManager].userInfo resetUserBehavior];
//            }
            
            //拼接url
            NSString *url = @"http://10.71.66.2:8001/a1";
            AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
            [sessionManager POST:url
                      parameters:@{@"value":userInfo.behaviorStr}
                        progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task,
                                   id  _Nullable responseObject) {
                             
                             NSLog(@"用户行为发送成功");
                             //                             NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求成功):%@",url,orgParas,responseObject);
                         }
                         failure:^(NSURLSessionDataTask * _Nullable task,
                                   NSError * _Nonnull error) {
                             //                             failure(task,error);
                             //                             NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求失败):%@",url,parameters,error);
                             NSLog(@"用户行为发送失败:%@",error);
                         }
             ];

            
        }
        NSLog(@"用户行为数据改变");
    }
    
    NSLog(@"KVO");
}

- (void)dealloc {
    
    [[NKAppManager shareManager].userInfo removeObserver:self forKeyPath:@"dataLength" context:nil];
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
