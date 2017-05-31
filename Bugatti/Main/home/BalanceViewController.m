//
//  BalanceViewController.m
//  Bugatti
//
//  Created by toby on 20/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "BalanceViewController.h"

@interface BalanceViewController ()

@property (nonatomic,strong) UIImageView *qrImgView;

@property (nonatomic,strong) UIView *backView;

@property (nonatomic) NSInteger time;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic) CGFloat currentLight;
@end

@implementation BalanceViewController

-(void)erweima {
    
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    

    NSData *data=[[NSString stringWithFormat:@"%s",getSerialWithUid([self.userData.user_id intValue])] dataUsingEncoding:NSUTF8StringEncoding];

    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    _qrImgView.image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    
    
    
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    
//    _imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
//    
//    _imgView.layer.shadowRadius=1;//设置阴影的半径
//    
//    _imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
//    
//    _imgView.layer.shadowOpacity=0.3;
}

//改变二维码大小

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

- (NSTimer *)timer{
    if(!_timer){
        if(IS_IOS10_LATER){
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [self ios10Before];
            }];
            
        }else{
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ios10Before) userInfo:nil repeats:YES];
        }

    }
            return _timer;
}

- (void)ios10Before{
    if(self.time > 0){
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"请在 %ld 秒后点击\n屏幕更换二维码",self.time--]];
        
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:20.0]
                              range:NSMakeRange(3, 2)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor greenColor]
                              range:NSMakeRange(3, 2)];
        
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.time = 9;
        [self erweima];
        [self.timer fire];
    }
}

- (UIImageView *)imgView{
    if(!_qrImgView){
        _qrImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width/2-40, self.backView.width/2-40)];
        _qrImgView.center = CGPointMake(self.backView.width/2, self.backView.height/2+30);
        
    }
     [self erweima];
    return _qrImgView;
}

- (UIView *)backView {
    if(!_backView){
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-VIEW_PACE*2, SCREEN_HEIGHT-VIEW_PACE*17)];
        _backView.layer.cornerRadius = 6;
        _backView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        _backView.backgroundColor = COLOR(255, 255, 255, 1);
        [_backView addSubview:self.imgView];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, _backView.width, 30)];
        lab.text = @"请向商家出示二维码";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = COLOR(44, 89, 45, 1);
        [_backView addSubview:lab];
    }
    return _backView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentLight = self.dataManager.deviceInfo.currentScreenLight;
    
    [self addWhiteBackbutton];
    self.view.backgroundColor = COLOR(98, 166, 52, 1);
    [self.view addSubview:self.backView];
    
    [self.timer fire];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
 
        [self.dataManager.deviceInfo setScreenBrightness:0.99];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [[UserDataManager shareManager].deviceInfo setScreenBrightness:self.currentLight];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.time = 9;
    }
    return self;
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
