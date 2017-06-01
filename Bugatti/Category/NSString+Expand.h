//
//  NSString+Expand.h
//  Bugatti
//
//  Created by toby on 31/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Expand)



/**
 计算字符串的字节数（包括了中文和英文混合的）

 @param str 字符串
 @return 字节长度
 */
- (int)convertToByte:(NSString*)str;


- (BOOL)isNULLString;
/**
 自定义行间距

 @param space 行间距
 @return 富文本
 */
- (NSAttributedString *)lineSpacingWithSpace:(NSInteger)space;

- (NSAttributedString *)me_name;
@end
