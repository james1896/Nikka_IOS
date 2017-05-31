//
//  DoubleWaves.m
//  DoubleWavesAnimation
//
//  Created by anyongxue on 2016/12/12.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "FirstWaves.h"

@interface FirstWaves ()

@property (nonatomic,strong)CADisplayLink *wavesDisplayLink;

@property (nonatomic,strong)CAShapeLayer *firstWavesLayer;

@property (nonatomic,strong)UIColor *firstWavesColor;

@end

@implementation FirstWaves
{
    CGFloat waveA;//水纹振幅
    CGFloat waveW ;//水纹周期
    CGFloat offsetX; //位移
    CGFloat currentK; //当前波浪高度Y
    CGFloat wavesSpeed;//水纹速度
    CGFloat WavesWidth; //水纹宽度
}

/*
 y =Asin（ωx+φ）+C
 A表示振幅，也就是使用这个变量来调整波浪的高度
 ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
 φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
 C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
 */

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.masksToBounds = YES;
        
        [self setUpWaves];
    }
    
    return self;
}


- (void)setUpWaves{
    
    //设置波浪的宽度
    WavesWidth = self.frame.size.width;
    
    //第一个波浪颜色
    self.firstWavesColor = [UIColor colorWithRed:55/255.0f green:157/255.0f blue:255/255.0f alpha:1];
    
    //设置波浪的速度
    wavesSpeed = 1/M_PI;
    
    //初始化layer
    if (self.firstWavesLayer == nil) {
        
        //初始化
        self.firstWavesLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        self.firstWavesLayer.fillColor = self.firstWavesColor.CGColor;
        //设置边缘线的颜色
        //        _firstWavesLayer.strokeColor = [UIColor blueColor].CGColor;
        //设置边缘线的宽度
        //self.firstWavesLayer.lineWidth = 1.0;
        //        self.firstWavesLayer.strokeStart = 0.0;
        //        self.firstWavesLayer.strokeEnd = 0.8;
        
        [self.layer addSublayer:self.firstWavesLayer];
    }
    
    
    //设置波浪流动速度
    wavesSpeed = 0.01;
    //设置振幅
    waveA = 30;
    //设置周期
    waveW = 0.48/30.0;
    
    //设置波浪纵向位置
    currentK = self.frame.size.height/2;//屏幕居中
    
    //启动定时器
//    self.wavesDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
//    
//    [self.wavesDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    offsetX = 16.560000;
    [self setCurrentFirstWaveLayerPath];
}

-(void)getCurrentWave:(CADisplayLink *)displayLink{
    
    //实时的位移
    //实时的位移
    offsetX += wavesSpeed;
    
    [self setCurrentFirstWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath{
 
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat y = currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    
    for (NSInteger i =0.0f; i<=WavesWidth; i++) {
        //正弦函数波浪公式
        y = waveA * sin(waveW * i+ offsetX)+currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    NSLog(@"yyyyy:%f",offsetX);
    if([self.delegate respondsToSelector:@selector(currentWavesHeight:)]){
        CGFloat f = waveA * sin(waveW * WavesWidth+ offsetX)+currentK;
        [self.delegate currentWavesHeight:f];
    }
    CGPathAddLineToPoint(path, nil, WavesWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    
    CGPathCloseSubpath(path);
    self.firstWavesLayer.path = path;
    
    //使用layer 而没用CurrentContext
    CGPathRelease(path);
    
}


-(void)dealloc
{
    [self.wavesDisplayLink invalidate];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
