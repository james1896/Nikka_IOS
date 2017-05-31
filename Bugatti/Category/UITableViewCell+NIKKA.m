//
//  UITableViewCell+NIKKA.m
//  Bugatti
//
//  Created by toby on 05/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "UITableViewCell+NIKKA.h"

@implementation UITableViewCell (NIKKA)

+ (instancetype)initNibName:(NSString *)name{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] lastObject];
}

@end
