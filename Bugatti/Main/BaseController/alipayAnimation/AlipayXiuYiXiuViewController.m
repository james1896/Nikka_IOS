//
//  AlipayXiuYiXiuViewController.m
//  Bugatti
//
//  Created by toby on 06/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "AlipayXiuYiXiuViewController.h"

@interface AlipayXiuYiXiuViewController ()

@end

@implementation AlipayXiuYiXiuViewController{
    UIView *_circleView;
}



/// 开始咻一咻动画
- (void)startXiuxiu:(UIButton *)button {
    
    // 1. 修改圆形视图背景颜色 61	107	147
    _circleView.backgroundColor = [UIColor colorWithRed:61 / 255.0 green:107 / 255.0 blue:147 / 255.0 alpha:1.0];
    
    // 2. 禁用按钮
    button.enabled = NO;
    
    CGFloat delay = 0.6;
    CGFloat scale = 3.5;
    NSInteger count = 20;
    
    // 3. 循环添加多个视图动画
    for (NSInteger i = 0; i < count; i++) {
        // 3. 创建一个圆形视图，添加到视图的底层
        UIView *animationView = [self circleView];
        animationView.backgroundColor = _circleView.backgroundColor;
        [self.view insertSubview:animationView atIndex:0];
        
        [UIView
         animateWithDuration:2
         delay:i * delay
         options:UIViewAnimationOptionCurveLinear
         animations:^{
             animationView.transform = CGAffineTransformMakeScale(scale, scale);
             animationView.backgroundColor = self.view.backgroundColor;
             animationView.alpha = 0;
         } completion:^(BOOL finished) {
             [animationView removeFromSuperview];
             
             if (i == count - 1) {
                 button.enabled = YES;
             }
         }];
    }
}

#pragma mark - 准备界面
- (void)setupUI {
    // 1. 设置背景颜色 35	39	63
    self.view.backgroundColor = [UIColor colorWithRed:35 / 255.0 green:39 / 255.0 blue:63 / 255.0 alpha:1.0];
    
    // 2. 添加按钮
    UIButton *button = [[UIButton alloc] init];
    
    [button setImage:[UIImage imageNamed:@"alipay_msp_op_success"] forState:UIControlStateNormal];
    
    // 注意：先调整大小，再设置中心点
    [button sizeToFit];
    button.center = self.view.center;
    
    [self.view addSubview:button];
    
    // 3. 添加圆形视图
    _circleView = [self circleView];
    [self.view insertSubview:_circleView belowSubview:button];
    
    // 4. 添加监听方法
    [button addTarget:self action:@selector(startXiuxiu:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)circleView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = self.view.center;
    
    // 设置背景颜色 52	 143	242
    view.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:143 / 255.0 blue:242 / 255.0 alpha:1.0];
    
    // 设置视图圆角
    view.layer.cornerRadius = 50.0;
    view.layer.masksToBounds = YES;
    
    return view;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
