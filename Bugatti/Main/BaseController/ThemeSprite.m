//
//  ThemeSprite.m
//  Bugatti
//
//  Created by toby on 09/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "ThemeSprite.h"

#define THEMESPRITE_MOVING_DISTANCE 15
@interface ThemeSprite(){
    CGPoint _beginPosition;
}

@property (nonatomic,strong)UIImageView *sprite;

@end
@implementation ThemeSprite

+(instancetype)shareSprite{
    return [ThemeSprite new];
}
- (UIImageView *)sprite{
    if(!_sprite){
        _sprite = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"themeSpirit"]];
    }
    return _sprite;
}

- (CGPoint)beginPosition{
   
//    if(cgp ){
//    
//    }
    return _beginPosition;
}
- (void)setBeginPosition:(CGPoint)beginPosition{
    _beginPosition = beginPosition;
    self.sprite.center = beginPosition;
}

- (void)moveUpAnimation{

}

- (void)moveDownAnimation{
    
}

- (void)moveLeftAnimation{
    
}
- (void)moveRightAnimation {
    
}
- (void)showInView:(UIView *)view{
    self.sprite.frame = CGRectMake(50, 50, 50, 50);
    self.sprite.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    
    [view addSubview:self.sprite];
    
    [UIView animateWithDuration:4 delay:0.1 usingSpringWithDamping:0.06 initialSpringVelocity:2 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        
        self.sprite.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-THEMESPRITE_MOVING_DISTANCE);
    } completion:^(BOOL finished) {
//         self.sprite.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-50);
        [self.sprite removeFromSuperview];
    }];
}
@end
