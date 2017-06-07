//
//  WhiteListModel.h
//  Bugatti
//
//  Created by toby on 06/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhiteListModel : NSObject



/**
 用户行为统计需要的 页面id

 @param name 当前类名
 @return 当前类名对应的id
 */
+ (NSInteger)getPageIDWithClassName:(NSString *)name;
@end
