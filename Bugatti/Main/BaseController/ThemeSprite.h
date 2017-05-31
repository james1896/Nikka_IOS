//
//  ThemeSprite.h
//  Bugatti
//
//  Created by toby on 09/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeSprite : NSObject

@property (nonatomic) CGPoint beginPosition;
+ (instancetype)shareSprite;

- (void)showInView:(UIView *)view;
@end
