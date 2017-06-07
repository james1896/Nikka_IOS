//
//  WhiteListModel.m
//  Bugatti
//
//  Created by toby on 06/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "WhiteListModel.h"

@implementation WhiteListModel

+ (NSDictionary *)getPageIDDictionary{
    return @{@"HomeViewController":@(101),
             @"GridViewController":@(102),
             @"MeViewController":@(103),};
}

+ (NSInteger)getPageIDWithClassName:(NSString *)name{
    NSNumber *pageId = [self getPageIDDictionary][name];
    
    if([pageId integerValue] != 0){
        return [pageId integerValue];
    }
    return 0;
}


@end
