//
//  HomeViewController.m
//  Bugatti
//
//  Created by toby on 09/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "HomeViewController.h"

#import "MeViewController.h"
#import "BalanceViewController.h"
#import "RecordViewController.h"
//#import "AcitivityViewController.h"

#import "UIImageView+WebCache.h"
#import "AFHTTPSessionManager.h"


#import "TBKeyChain.h"
#import "AmaenboController.h"

//#import "lib.h"

@interface LeidaView : UIView

@end

@implementation LeidaView

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [COLOR(22, 163, 130,1) setFill];
    UIRectFill(rect);
    NSInteger pulsingCount = 5;
    double animationDuration = 3;
    CALayer * animationLayer = [CALayer layer];
    for (int i = 0; i < pulsingCount; i++) {
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.borderColor = [UIColor whiteColor].CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = rect.size.height / 2;
        
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1.4;
        scaleAnimation.toValue = @2.2;
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        [animationLayer addSublayer:pulsingLayer];
    }
    [self.layer addSublayer:animationLayer];
}

@end

/*  ~~~~~~~~~~~~~~~~~~~~~~~     HomeViewController      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

@interface HomeViewController ()

//活动展示View
@property (nonatomic,strong) UIView *upView;
@property (nonatomic,strong) UIView *activityView;
@property (nonatomic,strong) UIView *buttonView;


//撒娇语言
//banner
@property(nonatomic,strong) UILabel *amaenboLab;

@property (nonatomic,strong) UIImageView *bannerImg;

@end

@implementation HomeViewController

/*  ~~~~~~~~~~~~~~~~~~~~~~~     BUTTON 点击事件      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark - BUTTON 点击事件
- (void)actionTap:(UITapGestureRecognizer *)tap {
    switch (tap.view.tag) {
        case 0:{
            
//            if([UserDataManager shareManager].isLogin){
//                BalanceViewController *balance = [[BalanceViewController alloc]init];
//                [self.navigationController pushViewController:balance animated:YES];
//            }else{
//                [self.baseTabbarController showLoginController];
//            }
         
            [self.baseTabbarController showLoginControllerWithDesiredController:[[BalanceViewController alloc]init]];
         break;
        }
        case 1:{
//            AcitivityViewController *activity = [[AcitivityViewController alloc]init];
//            [self.navigationController pushViewController:activity animated:YES];
            ActivityController *activity = [[ActivityController alloc]init];
            [self.navigationController pushViewController:activity animated:YES];
            break;
        }
        case 2:{
            RecordViewController *record = [[RecordViewController alloc]init];
            [self.navigationController pushViewController:record animated:YES];
            break;
        }
            
        default:
            break;
    }
}

//撒娇语言
- (void)amaenboPress{
    AmaenboController *amaenbo = [[AmaenboController alloc]init];
    [self.navigationController pushViewController:amaenbo animated:YES];
    
}


- (void)activityViewPress{
   
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     lift cycle      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */
-(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[TBKeyChain load:@"com.company.app.usernamepassword"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [TBKeyChain save:@"com.company.app.usernamepassword" data:strUUID];
        
    }
    return strUUID;
}

#pragma mark - lift cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
////    NSLog(@"char === %d",say_hello());

    
//    [TBRuquestManager testWithParameters:@{@"aa":@"TEST_API"} success:^(NSURLSessionDataTask *task, id responseObject) {
////         NSLog(@"responseObject:%@",responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//    
//    [TBRuquestManager test1WithParameters:@{@"test1":@"TEST1_API"} success:^(NSURLSessionDataTask *task, id responseObject) {
//        //         NSLog(@"responseObject:%@",responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.upView atIndex:0];
    [self.view addSubview:[self downView]];
     self.titleName = @"Nikka";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*  ~~~~~~~~~~~~~~~~~~~~~~~     SET GET 方法      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark - SET GET 方法

- (UIView *)activityView{
    if(!_activityView){
        
        CGFloat width = self.view.width;
        CGFloat height =self.upView.height-NAV_BOTTOM-self.buttonView.height;
        _activityView = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_BOTTOM, width, height)];
        
        UILabel *pointRankLab       = [UILabel new];
        UILabel *pointRank          = [UILabel new];
        UILabel *actNumberLab       = [UILabel new];
        UILabel *actNumber          = [UILabel new];
        UILabel *remainPointLab     = [UILabel new];
        UILabel *remainPoint        = [UILabel new];
       
        pointRankLab.textAlignment  = NSTextAlignmentRight;
        pointRank.textAlignment     = NSTextAlignmentRight;
        actNumberLab.textAlignment  = NSTextAlignmentRight;
        actNumber.textAlignment     = NSTextAlignmentRight;
        remainPointLab.textAlignment= NSTextAlignmentRight;
        remainPoint.textAlignment   = NSTextAlignmentCenter;
        
        pointRankLab.text       = @"用户积分排行";
        pointRank.text          = @"108";
        actNumberLab.text       = @"本次活动编号";
        actNumber.text          = @"10900";
        remainPointLab.text     = @"活动剩余积分";
        remainPoint.text        = @"1999";
        
        pointRankLab.textColor  = COLOR(22, 91, 39, 1);
        actNumberLab.textColor  = COLOR(22, 91, 39, 1);
        remainPointLab.textColor= COLOR(22, 91, 39, 1);
        pointRank.textColor     = COLOR(22, 91, 39, 1);
        actNumber.textColor     = COLOR(22, 91, 39, 1);
        remainPoint.textColor   = COLOR(22, 91, 39, 1);
        
        pointRankLab.font       = APP_FONT(18);
        pointRank.font          = APP_FONT(18);
        actNumberLab.font       = APP_FONT(18);
        actNumber.font          = APP_FONT(18);
        remainPointLab.font     = APP_FONT(18);
        remainPoint.font        = APP_FONT(18);
        
        [_activityView addSubview:pointRankLab];
        [_activityView addSubview:pointRank];
        [_activityView addSubview:actNumberLab];
        [_activityView addSubview:actNumber];
        [_activityView addSubview:remainPointLab];
        [_activityView addSubview:remainPoint];
        
        
        NSMutableArray *leftArray = [NSMutableArray new];
        [leftArray addObject:pointRankLab];
        [leftArray addObject:pointRank];
        [leftArray addObject:actNumberLab];
        [leftArray addObject:actNumber];
        NSMutableArray *rightArray = [NSMutableArray new];
        [rightArray addObject:remainPointLab];
        [rightArray addObject:remainPoint];
       
        [leftArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
        [rightArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:30 tailSpacing:30];
        [leftArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_activityView).with.offset(VIEW_PACE);
            make.width.equalTo(@[pointRankLab]);
        }];
        [rightArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_activityView).with.offset(-VIEW_PACE);
            make.width.equalTo(@[remainPointLab]);
        }];
    
    }
    return _activityView;
}

- (UIView *)buttonView{
    if(!_buttonView){
    _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-SCREEN_HEIGHT/5, SCREEN_WIDTH, SCREEN_HEIGHT/5)];
         self.buttonView.backgroundColor = COLOR(70, 169, 15, 1);
    }
    return _buttonView;
}

- (UIView *)upView{
    if(!_upView){
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _upView.backgroundColor = COLOR(86, 181, 8, 1);
        
//        LeidaView *leida = [[LeidaView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 80, 60 , 60)];
//        [self.view addSubview:leida];
        
        [_upView addSubview:self.activityView];
        //三个button 的 View
        [_upView addSubview:self.buttonView];
        
        UIView *bgView1 = [UIView new];
        bgView1.frame = CGRectMake(0,0, self.buttonView.height/2.6, self.buttonView.height/1.8);
        bgView1.center = CGPointMake(self.buttonView.width*0.2, self.buttonView.height/2);
        [self.buttonView addSubview:bgView1];
        
        UIView *bgImg1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bgView1.width, bgView1.width)];
        bgImg1.layer.cornerRadius = bgImg1.width/2;
        bgImg1.backgroundColor = COLOR(22, 91, 39, 1);
        [bgView1 addSubview:bgImg1];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, bgView1.height-18, bgView1.width*2, 25)];
        lab1.text = @"我的储蓄";
        lab1.font = [UIFont systemFontOfSize:13];
        lab1.textColor = [UIColor whiteColor];
        [bgView1 addSubview:lab1];
        
        UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_bankcard"]];
        img1.center = CGPointMake(bgImg1.width/2, bgImg1.height/2);
        [bgImg1 addSubview:img1];
        
        
        
        UIView *bgView2 = [UIView new];
        bgView2.frame = CGRectMake(0,0, self.buttonView.height/2.6, self.buttonView.height/1.8);
        bgView2.center = CGPointMake(self.buttonView.width*0.5, self.buttonView.height/2);
        [self.buttonView addSubview:bgView2];
        UIView *bgImg2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bgView1.width, bgView1.width)];
        bgImg2.layer.cornerRadius = bgImg2.width/2;
        bgImg2.backgroundColor = COLOR(22, 91, 39, 1);
        [bgView2 addSubview:bgImg2];
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, bgView2.height-18, bgView2.width*2, 25)];
        lab2.text = @"优惠活动";
        lab2.font = [UIFont systemFontOfSize:13];
        lab2.textColor = [UIColor whiteColor];
        [bgView2 addSubview:lab2];
        UIImageView *img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_preference"]];
        img2.center = CGPointMake(bgImg2.width/2, bgImg2.height/2);
        [bgImg2 addSubview:img2];
        
        
        
        UIView *bgView3 = [UIView new];
        bgView3.frame = CGRectMake(0,0, self.buttonView.height/2.6, self.buttonView.height/1.8);
        bgView3.center = CGPointMake(self.buttonView.width*0.8, self.buttonView.height/2);
        [self.buttonView addSubview:bgView3];
        UIView *bgImg3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bgView1.width, bgView1.width)];
        bgImg3.layer.cornerRadius = bgImg3.width/2;
        bgImg3.backgroundColor = COLOR(22, 91, 39, 1);
        [bgView3 addSubview:bgImg3];
        UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, bgView3.height-18, bgView3.width*2, 25)];
        lab3.text = @"消费纪录";
        lab3.font = [UIFont systemFontOfSize:13];
        lab3.textColor = [UIColor whiteColor];
        [bgView3 addSubview:lab3];
        
        UIImageView *img3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_ticket"]];
        img3.center = CGPointMake(bgImg3.width/2, bgImg3.height/2);
        [bgImg3 addSubview:img3];
        
        
        bgView1.tag = 0;
        bgView2.tag = 1;
        bgView3.tag = 2;
        
        [bgView1 addTapGestureRecognizerWithTarget:self action:@selector(actionTap:)];
        [bgView2 addTapGestureRecognizerWithTarget:self action:@selector(actionTap:)];
        [bgView3 addTapGestureRecognizerWithTarget:self action:@selector(actionTap:)];
     
    }
    return _upView;
}


- (UIView *)downView {
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, self.upView.bottom, self.upView.width, self.view.height-self.upView.height)];

    self.amaenboLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, downView.width, 50)];
    self.amaenboLab.text = @"Here's the loyalty program app";
    self.amaenboLab.textColor = COLOR(138, 190, 80, 1);
    [self.amaenboLab addTapGestureRecognizerWithTarget:self action:@selector(amaenboPress)];
    
    [downView addSubview:self.amaenboLab];
    [downView addSubview:self.bannerImg];
    return downView;
}

//- (UILabel *)amaenboLab{
//    if(!_amaenboLab){
//        _amaenboLab = [[UILabel ]];
//    }
//    return _amaenboLab;
//}

- (UIImageView *)bannerImg{
    if(!_bannerImg){
        
        UIImage *img = [UIImage imageNamed:@"home_banner"];
         _bannerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, self.view.height-self.upView.bottom-50-49)];
        [_bannerImg sd_setImageWithURL:[NSURL URLWithString:@"http://10.66.67.81:8001/client/image/1"]placeholderImage:img];
        
      

    }
    return _bannerImg;
}

@end
