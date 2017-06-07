//
//  TBLoginViewController.m
//  Bugatti
//
//  Created by toby on 28/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "TBLoginViewController.h"
#import "CSTextField.h"
#import "TBKeyChain.h"
#import "TBPredicate.h"



///////////////////////////////     TBShowView       ///////////////////////////////////////////////////

@interface TBShowView : UIView

@end

@implementation TBShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor magentaColor];
        
    }
    return self;
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    button.layer.borderWidth = 1;
    button.layer.borderColor = COLOR(182, 184,189, 1).CGColor;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitleColor:COLOR(236, 236,236, 1) forState:UIControlStateNormal];
    return button;
}

@end

///////////////////////////////     LoginView       ///////////////////////////////////////////////////

@interface BaseLoginView : UIView

- (void)allTextfieldsResignFirstResponder;
@end
@implementation BaseLoginView

- (void)allTextfieldsResignFirstResponder{
    
}

@end

@interface LoginView : BaseLoginView

@property (nonatomic,weak) TBLoginViewController *loginController;

@property (nonatomic,strong) CSTextField *userName;
@property (nonatomic,strong) CSTextField *password;
@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ningmeng.jpeg"]];
        imgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self addSubview:imgView];
        
        UIView *maskView = [[UIView alloc] initWithFrame:imgView.bounds];
        maskView.backgroundColor = COLOR(0, 0, 0, 0.4);
        [maskView.layer addSublayer:[self backgroundLayer]];
        [self addSubview:maskView];
        
        
        [self addSubview:self.userName];
        [self addSubview:self.password];
        //
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        button.frame = CGRectMake(self.password.left, self.password.bottom+30, self.password.width, 50);;
        button.layer.borderWidth = 1;
        button.layer.borderColor = COLOR(182, 184,189, 1).CGColor;
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:COLOR(236, 236,236, 1) forState:UIControlStateNormal];
        [button addTarget:self.loginController action:@selector(loginButonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.frame = CGRectMake(15, SCREEN_HEIGHT-40, 26, 26);
        [back setBackgroundImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:back];
        
    }
    return self;
}

-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)COLOR(67, 223, 255, 0.2).CGColor,(__bridge id)COLOR(55, 142, 255, 0.3).CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    gradientLayer.locations = @[@0.4,@1];
    return gradientLayer;
}

- (void)backbutton:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)allTextfieldsResignFirstResponder{
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}

- (CSTextField *)userName{
    if(!_userName){
        _userName = [[CSTextField alloc]initWithFrame:CGRectMake(20, self.bounds.size.height/2-10, self.width-40, 40)];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.placeholder = @"账户用户名";
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.userName.height+1, self.userName.width, 1)];
        line.backgroundColor = COLOR(178, 178, 178, 0.7);
        [_userName addSubview:line];
    }
    return _userName;
}

- (CSTextField *)password{
    if(!_password){
        _password = [[CSTextField alloc]initWithFrame:CGRectMake(20, self.userName.bottom+20, self.width-40, 40)];
        _password.textAlignment = NSTextAlignmentCenter;
        _password.placeholder = @"请输入密码";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.password.height+1, self.password.width, 1)];
        line.backgroundColor = COLOR(178, 178, 178, 0.7);
        [_password addSubview:line];
        
    }
    return _password;
}

@end

///////////////////////////////     RegisterView       ///////////////////////////////////////////////////

@interface RegisterView : UIView
@property (nonatomic,weak) TBLoginViewController *loginController;
@property (nonatomic,strong) CSTextField *userName;
@property (nonatomic,strong) CSTextField *password;
@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ningmeng.jpeg"]];
        imgView.frame = self.bounds;
        [self addSubview:imgView];
        UIView *maskView = [[UIView alloc] initWithFrame:imgView.bounds];
        maskView.backgroundColor = COLOR(0, 0, 0, 0.4);
        [maskView.layer addSublayer:[self backgroundLayer]];
        [imgView addSubview:maskView];
        
        
        [self addSubview:self.userName];
        [self addSubview:self.password];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        button.frame = CGRectMake(self.password.left, self.password.bottom+30, self.password.width, 50);;
        button.layer.borderWidth = 1;
        button.layer.borderColor = COLOR(182, 184,189, 1).CGColor;
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self.loginController action:@selector(registerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:COLOR(236, 236,236, 1) forState:UIControlStateNormal];
        [self addSubview:button];
        
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.frame = CGRectMake(15, SCREEN_HEIGHT-40, 26, 26);
        [back setBackgroundImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:back];
        
    }
    return self;
}

- (void)allTextfieldsResignFirstResponder{
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}

-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)COLOR(67, 223, 255, 0.2).CGColor,(__bridge id)COLOR(55, 142, 255, 0.3).CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    gradientLayer.locations = @[@0.4,@1];
    return gradientLayer;
}

- (void)backbutton:(UIButton *)sender {
    [self removeFromSuperview];
}


- (CSTextField *)userName{
    if(!_userName){
        _userName = [[CSTextField alloc]initWithFrame:CGRectMake(20, self.bounds.size.height/2-10, self.width-40, 40)];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.placeholder = @"请输入手机号";
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.userName.height+1, self.userName.width, 1)];
        line.backgroundColor = COLOR(178, 178, 178, 0.7);
        [_userName addSubview:line];
    }
    return _userName;
}

- (CSTextField *)password{
    if(!_password){
        _password = [[CSTextField alloc]initWithFrame:CGRectMake(20, self.userName.bottom+20, self.width-40, 40)];
        _password.textAlignment = NSTextAlignmentCenter;
        _password.placeholder = @"请输入验证码";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.password.height+1, self.password.width, 1)];
        line.backgroundColor = COLOR(178, 178, 178, 0.7);
        [_password addSubview:line];
        
    }
    return _password;
}

@end

///////////////////////////////     TBLoginViewController       ///////////////////////////////////////////////////

@interface TBLoginViewController ()



@property (nonatomic,strong) TBShowView         *showView;
@property (nonatomic,strong) LoginView          *loginView;
@property (nonatomic,strong) RegisterView       *registerView;

@end

@implementation TBLoginViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ningmeng.jpeg"]];
    imgView.frame = self.view.bounds;
    [self.view addSubview:imgView];
    UIView *maskView = [[UIView alloc] initWithFrame:imgView.bounds];
    maskView.backgroundColor = COLOR(0, 0, 0, 0.4);
    [maskView.layer addSublayer:[self backgroundLayer]];
    [imgView addSubview:maskView];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(30, self.view.height/2-100, self.view.width-60, 80)];
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentCenter;
    
    lab.font = [UIFont boldSystemFontOfSize:22];
    lab.text = @"Open the world to a new flavor";
    [self.view addSubview:lab];
    
    
    UIButton *loginButton =[self createButtonWithFrame:CGRectMake(lab.left, lab.bottom+80, lab.width/2-10, 50) title:@"登录"];
    [self.view addSubview:loginButton];
    UIButton *registerButton = [self createButtonWithFrame:CGRectMake(loginButton.right+10, loginButton.top, loginButton.width, 50) title:@"注册"];
    [self.view addSubview:registerButton];
    
    UIButton *wechatButton = [self createButtonWithFrame:CGRectMake(loginButton.left,loginButton.bottom+20,loginButton.width*2+10, 50) title:@"使用微信账号登录"];
    [self.view addSubview:wechatButton];
    
    [loginButton addTarget:self action:@selector(showLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton addTarget:self action:@selector(showRegisterView:) forControlEvents:UIControlEventTouchUpInside];
    [wechatButton addTarget:self action:@selector(wechatButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTap:)];
    [self.view addGestureRecognizer:tap];
    
    [self addWhiteBackbutton];
}

- (void)showLoginButton:(UIButton *)sender {
    if(!self.loginView.superview){
        [self.view addSubview:self.loginView];
    }
    self.loginView.password.text = @"";
}

- (void)showRegisterView:(UIButton *)sender {
    if(!self.registerView.superview){
        [self.view addSubview:self.registerView];
    }
    
    self.registerView.password.text = @"";
}

- (void)wechatButtonPress:(UIButton *)sender {
    
}


- (void)loginButonPress:(UIButton *)sender {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    NSString *name = self.loginView.userName.text;
    NSString *pwd  = self.loginView.password.text;
//    TBPreResult *result = [TBPredicate checkUserName:name];
    
    //    if(!result.evaluate){
    //        [TBToastView showToastViewWithText:result.desc];
    //        return;
    //    }
    //
    //    result = [TBPredicate checkPassword:pwd];
    //    if(!result.evaluate){
    //        [TBToastView showToastViewWithText:result.desc];
    //        return;
    //    }
    
    [TBRuquestManager loginWithName:name
                           password:pwd
                               uuid:[[NKAppManager shareManager].deviceInfo getUUID]
                             device:[APPUtils getDeviceModel]
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                if([responseObject dataFormatIsRight]){
                                    if([self.delegate respondsToSelector:@selector(loginSuccessedController:)]){
                                        [self.loginView allTextfieldsResignFirstResponder];
                                        [self.delegate loginSuccessedController:self];
                                    }
                                    
                                    self.userInfo.userName = name;
                                    self.userInfo.password = pwd;
                                    self.userInfo.user_id = [responseObject getUserIDInData];
                                    self.userInfo.moneyPoints = [[responseObject getPointsInData] floatValue];
                                    
                                }
                                
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                            }];
    
}

- (void)registerButtonPress:(UIButton *)sender {
    
    NSString *name = self.registerView.userName.text;
    NSString *pwd  = self.registerView.password.text;
//    TBPreResult *result = [TBPredicate checkUserName:name];
    
    //    if(!result.evaluate){
    //        [TBToastView showToastViewWithText:result.desc];
    //        return;
    //    }
    //
    //    result = [TBPredicate checkPassword:pwd];
    //    if(!result.evaluate){
    //        [TBToastView showToastViewWithText:result.desc];
    //        return;
    //    }
    
    
    [TBRuquestManager registerWithName:name
                              password:pwd
                                  uuid:[[NKAppManager shareManager].deviceInfo getUUID]
                                device:[APPUtils getDeviceModel]
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   
                                   
                                   if([responseObject dataFormatIsRight]){
                                       
                                       if([responseObject isTrueCode]){
                                           if([self.delegate respondsToSelector:@selector(loginSuccessedController:)]){
                                               
                                               [self.registerView allTextfieldsResignFirstResponder];
                                               [self.delegate loginSuccessedController:self];
                                           }
                                           
                                           self.userInfo.userName = name;
                                           self.userInfo.password = pwd;
                                           self.userInfo.user_id = [responseObject getUserIDInData];
                                           self.userInfo.moneyPoints = [[responseObject getPointsInData] floatValue];
                                           
                                       }else if ([[responseObject getStatusCodeInData] isEqualToNumber: @(4001)]){
                                           
                                           [TBToastView showToastViewWithText:@"用户名已经存在"];
                                       }
                                   }
                                   
                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   
                               }];
    
}

- (void)bgTap:(UITapGestureRecognizer *)tap {
    [self.loginView.userName resignFirstResponder];
    [self.loginView.password resignFirstResponder];
    [self.registerView.userName resignFirstResponder];
    [self.registerView.password resignFirstResponder];
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    button.layer.borderWidth = 1;
    button.layer.borderColor = COLOR(182, 184,189, 1).CGColor;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitleColor:COLOR(236, 236,236, 1) forState:UIControlStateNormal];
    return button;
}

- (LoginView *)loginView{
    if(!_loginView){
        _loginView = [[LoginView alloc]initWithFrame:self.view.bounds];
        _loginView.loginController = self;
    }
    
    return _loginView;
}

- (RegisterView *)registerView{
    if(!_registerView){
        _registerView = [[RegisterView alloc]initWithFrame:self.view.bounds];
        _registerView.loginController = self;
    }
    
    return _registerView;
}

-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)COLOR(67, 223, 255, 0.2).CGColor,(__bridge id)COLOR(55, 142, 255, 0.3).CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    gradientLayer.locations = @[@0.4,@1];
    return gradientLayer;
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
