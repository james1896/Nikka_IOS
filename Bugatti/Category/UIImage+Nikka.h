//
//  UIImage+Nikka.h
//  Bugatti
//
//  Created by toby on 09/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Nikka)

//按照指定的尺寸 裁剪图片

//  input 4.9M 图片
//    裁剪 size (480, 360)
//    output  20k

-(UIImage*)cutImageWithtargetSize: (CGSize)targetSize;

@end
