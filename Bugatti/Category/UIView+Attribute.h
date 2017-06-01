//
//  UIView+Attribute.h
//  Bugatti
//
//  Created by toby on 09/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Attribute)


- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)action;


/**
 *  左边距
 */
@property (nonatomic) CGFloat left;
/**
 *  顶部边距
 */
@property (nonatomic) CGFloat top;
/**
 *  右边距
 */
@property (nonatomic) CGFloat right;
- (CGFloat)width;

- (CGFloat)height;

- (CGFloat)bottom;
@end
