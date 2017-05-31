//
//  NSString+Expand.m
//  Bugatti
//
//  Created by toby on 31/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "NSString+Expand.h"

@implementation NSString (Expand)


/**
 是否是空字符串
 
 @return bool
 */
- (BOOL)isNULLString{
    if(((self == nil) ||
        [self isKindOfClass:[NSNull class]]||
        ![self isKindOfClass:[NSString class]])||
       [self isEqualToString:@""] ||
       [self isEqualToString:@""] ||
       [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        
        return YES;
    }
    return NO;
}

/**
 自定义行间距
 
 */
- (NSAttributedString *)lineSpacingWithSpace:(NSInteger)space{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    //    paragraphStyle.lineSpacing = 15;// 字体的行间距
    paragraphStyle.lineSpacing = space;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    
    return  [[NSAttributedString alloc] initWithString:self attributes:attributes];
}


/**
 <#Description#>
 
 
 */
- (NSAttributedString *)me_name{
    NSString *secondStr = [NSString stringWithFormat:@" | %@",self];
    NSMutableAttributedString *secondAttributedStr = [[NSMutableAttributedString alloc]initWithString:secondStr];
    [secondAttributedStr addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:24]
                                range:NSMakeRange(0, 1)];
    return secondAttributedStr;
}
@end
