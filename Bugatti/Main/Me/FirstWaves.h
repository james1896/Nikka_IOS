//
//  DoubleWaves.h
//  DoubleWavesAnimation
//
//  Created by anyongxue on 2016/12/12.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SineWavesDelegate;


@interface FirstWaves : UIView

@property (nonatomic) CGFloat wavesSpeed;

//振幅
@property (nonatomic) CGFloat waveA;

@property (nonatomic,weak) id<SineWavesDelegate> delegate;

@end

@protocol SineWavesDelegate <NSObject>

@optional
- (void)currentWavesHeight:(CGFloat)height;

@end
