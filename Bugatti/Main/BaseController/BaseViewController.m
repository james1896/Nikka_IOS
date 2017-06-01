//
//  BaseViewController.m
//  Bugatti
//
//  Created by toby on 09/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "BaseViewController.h"

#import "NextViewController.h"



//-------------------   BaseNavbarView  -------------------------

@interface BaseNavbarView : UIView

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *spaceLab;
@property (nonatomic,strong) UILabel *subtitle;

@property (nonatomic) NavTitleAlignment titleAlignment;

@end

@interface BaseNavbarView()

@end

@implementation BaseNavbarView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        
        [self addSubview:self.titleLab];
        [self addSubview:self.subtitle];
    }
    return self;
}

- (UILabel *)titleLab{
    if(!_titleLab){
        CGFloat width = SCREEN_WIDTH/6.0;
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_PACE, 20, width, self.height-20)];
        _titleLab.font = APP_FONT(24);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.text = @"USERNAME";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.userInteractionEnabled = YES;
        
    }
    return _titleLab;
}

- (UILabel *)spaceLab{
    if(!_spaceLab){
        _spaceLab = [[UILabel alloc] initWithFrame:CGRectMake(-8, self.subtitle.height-self.titleLab.height, 4, self.titleLab.height)];
        _spaceLab.text = @"|";
        _spaceLab.font = [UIFont systemFontOfSize:24];
        _spaceLab.textColor = [UIColor whiteColor];
        _spaceLab.textAlignment = NSTextAlignmentCenter;
        [self.subtitle addSubview:_spaceLab];
    }
    return _spaceLab;
}

- (UILabel *)subtitle{
    if(!_subtitle){
        _subtitle = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLab.right + 15, self.titleLab.top + 7, 0, 0)];
        _subtitle.font = [UIFont systemFontOfSize:13.5];
        _subtitle.textColor = [UIColor whiteColor];
    }
    return _subtitle;
}

- (void)setTitleAlignment:(NavTitleAlignment)titleAlignment{
     CGFloat width = SCREEN_WIDTH/3.0;
    switch (titleAlignment) {
        case NavTitleAlignmentLeftEdge:
            self.titleLab.frame = CGRectMake(LEFT_EGDE, 20, width, self.height-20);
            break;
            
        case NavTitleAlignmentLeft:{
            self.titleLab.frame = CGRectMake(VIEW_PACE, 20, width, self.height-20);
             break;
        }
            default:
            break;
    }
}

@end

//-------------------   BaseViewController  -------------------------

@interface BaseViewController ()

@property (nonatomic,strong) NSArray *dataArray;

//nav
@property (nonatomic,strong) BaseNavbarView *navbarView;

@property (nonatomic,strong) UIImageView *backgroundImageView;

@end

@implementation BaseViewController

#pragma mark  - 公开方法

- (void)addWhiteBackbutton{
    UIButton *button = [UIButton createWhiteBackButtonWithTarget:self action:@selector(backbutton:)];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    
}

- (void)addGrayBackbutton{
    
    UIButton *button = [UIButton createGrayBackButtonWithTarget:self action:@selector(backbutton:)];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    
}

- (void)addPinkBackbutton{
    UIButton *button = [UIButton createPinkBackButtonWithTarget:self action:@selector(backbutton:)];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
}


#pragma mark - SliderBarAnimationViewDelegate

//- (NSInteger)numberOfRowsInSliderBarView:(nonnull SliderBarAnimationView *)sliderBarView{
//    return self.dataArray.count;
//}
//
//- (void)sliderBarView:(nonnull SliderBarAnimationView *)sliderBarView didSelectRow:(NSInteger)row {
//      NSLog(@"sliderBarView row:%ld",row);
//    self.sliderBarView.userInteractionEnabled = YES;
//    [self.sliderBarView closeView:^{
//        [self.sliderBarView removeFromSuperview];
//        NextViewController *next = [[NextViewController alloc]init];
//        next.point = CGPointMake(80, row*65);
//        [self presentViewController:next animated:YES completion:nil];
//    }];
//}
//
////datasource
//- ( nonnull SliderBarViewCell *)sliderBarView:(nonnull SliderBarAnimationView *)sliderBarView cellForRowAt:(NSInteger)row{
//    SliderBarViewCell *cell = [sliderBarView dequeueReusableCellWithIdentifier:@"" atRow:row];
//    cell.textLab.text = self.dataArray[row];
//    return cell;
//}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     SET GET 方法      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark SET GET 方法

- (void)setNavbarBackgroundColor:(UIColor *)navbarBackgroundColor{
    self.navbarView.backgroundColor = navbarBackgroundColor;
}
- (UserDataManager *)dataManager{
    return [UserDataManager shareManager];
}

- (UserManager *)userData{
    
    return [UserDataManager shareManager].userManager;
}

- (void)setTitleColor:(UIColor *)titleColor{
    self.navbarView.titleLab.textColor = titleColor;
}

- (UIImageView *)backgroundImageView{
    if(!_backgroundImageView){
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _backgroundImageView;
}
- (void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    self.navbarView.titleLab.text = titleName;
    [self.navbarView.titleLab textSizeTofit];
    
}

- (void)setSubtitleName:(NSString *)subtitleName{
    
    if([subtitleName isEqualToString:@""]){
        self.navbarView.subtitle.text = @"";
        self.navbarView.spaceLab.text = @"";
        return;
    }
    _subtitleName = subtitleName;
  
    self.navbarView.subtitle.text = subtitleName;
    [self.navbarView.subtitle textSizeTofit];
    self.navbarView.spaceLab.text = @"|";
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    
    
    
}

- (void)setTitleAlignment:(NavTitleAlignment)titleAlignment{
    self.navbarView.titleAlignment = titleAlignment;
}

- (BaseNavbarView *)navbarView{
    if(!_navbarView){
        _navbarView = [[BaseNavbarView alloc]init];
         [self.view addSubview:_navbarView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(navbarPress)];
        [_navbarView addGestureRecognizer:tap];
    }
    return _navbarView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    self.backgroundImageView.image = backgroundImage;
    UIView *maskView = [[UIView alloc] initWithFrame:self.backgroundImageView.bounds];
    
    CGFloat r = arc4random()%100+100;
    CGFloat g = arc4random()%200+50;
    CGFloat b = arc4random()%100+150;
    
    maskView.backgroundColor = COLOR(r, g, b, 0.3);
    [self.view insertSubview:self.backgroundImageView atIndex:0];
}


/*  ~~~~~~~~~~~~~~~~~~~~~~~     lift cycle      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

- (void)navbarPress{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

#pragma mark - lift cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
}


- (void)backbutton:(UIButton *)sender {
    if(self.navigationController){
       [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
        
        }];
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


/*  ~~~~~~~     UIViewController(UIViewControllerItem)     ~~~~~~~~~~~~~~~   */

#pragma mark UIViewController(UIViewControllerItem)
@implementation UIViewController(UIViewControllerItem)


- (BaseTabBarController *)baseTabbarController{
    if([self.tabBarController isMemberOfClass:[BaseTabBarController class]]){
        return (BaseTabBarController *)self.tabBarController;
    }
    return nil;
}

- (BaseNavigationController *)baseNavigationController{
    if([self.tabBarController isMemberOfClass:[BaseNavigationController class]]){
        return (BaseNavigationController *)self.navigationController;
    }
    return nil;
}

@end
