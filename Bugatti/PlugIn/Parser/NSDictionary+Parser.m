//
//  NSDictionary+Category.m
//  Bugatti
//
//  Created by toby on 20/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "NSDictionary+Parser.h"

@implementation NSDictionary (Parser)


- (BOOL)isTrueCode{

    return [[self objectForKey:parser_statusCode] isEqualToNumber:parser_trueCode];
}

- (NSNumber *)getStatusCodeInData{
    
    if(![self isKindOfClass:[NSDictionary class]]){
        
        NSAssert(0, @"getStatusCode 对象不是NSDictionary");
        return @(0);
    }
   return [self objectForKey:parser_statusCode];
}

- (NSString *)getPointsInData{
    
    NSDictionary *dict = [self objectForKey:parser_data];
    return [dict objectForKey:parser_points];
}

- (NSString *)getUserIDInData{

    NSDictionary *dict = [self objectForKey:parser_data];
    return [dict objectForKey:parser_userID];
}

- (BOOL)dataFormatIsRight{

    if(![self isKindOfClass:[NSDictionary class]]){
#if DEBUG
        NSLog(@"the class is not a NSDictionary,please check again");
        return NO;
#endif
        return NO;
    }
    
    //绑定服务端数据的
    //包含key值 ：data
    //包含key值 ：statusCode
    //通过data得到的是dictionary
    if([self isContainKey:parser_data] &&
       [self isContainKey:parser_statusCode] &&
       [[self objectForKey:parser_data]isKindOfClass:[NSDictionary class]]){
        return YES;
    }
    return NO;
}


- (BOOL)isContainKey:(NSString *)key{
    return [[self allKeys] containsObject:key];
}

@end
