//
//  NSString+Expand.h
//  Bugatti
//
//  Created by toby on 31/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Nikka)



/**
 计算字符串的字节数（包括了中文和英文混合的）

 @param str 字符串
 @return 字节长度
 */
- (int)convertToByte:(NSString*)str;
//还不知道这两种做法的区别
//中文占3个  英文 1个
//NSUInteger bytes = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];



- (BOOL)isNULLString;
/**
 自定义行间距

 @param space 行间距
 @return 富文本
 */
- (NSAttributedString *)lineSpacingWithSpace:(NSInteger)space;

- (NSAttributedString *)me_name;
@end
