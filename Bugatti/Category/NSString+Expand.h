//
//  NSString+Expand.h
//  Bugatti
//
//  Created by toby on 31/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Expand)


- (BOOL)isNULLString;
/**
 自定义行间距

 @param space 行间距
 @return 富文本
 */
- (NSAttributedString *)lineSpacingWithSpace:(NSInteger)space;

- (NSAttributedString *)me_name;
@end
