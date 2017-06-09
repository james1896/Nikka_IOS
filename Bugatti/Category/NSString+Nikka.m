//
//  NSString+Expand.m
//  Bugatti
//
//  Created by toby on 31/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "NSString+Nikka.h"

//md5
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Nikka)


//md5
- (NSString *)stringToMD5
{
    
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [self UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}


- (int)convertToByte:(NSString*)str {
    int strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}



/**
 是否是空字符串
 
 @return bool
 */
- (BOOL)isNULLString{
    if(((self == nil) ||
        [self isKindOfClass:[NSNull class]]||
        ![self isKindOfClass:[NSString class]])||
       [self isEqualToString:@""]||
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
