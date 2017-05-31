//
//  NSDictionary+Category.h
//  Bugatti
//
//  Created by toby on 20/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Parser)

//绑定服务端数据
- (BOOL)dataFormatIsRight;
- (BOOL)isTrueCode;

- (NSNumber *)getStatusCodeInData;
- (NSString *)getUserIDInData;
- (NSString *)getPointsInData;

@end
