//
//  PasswordTextField.m
//  Password
//
//  Created by toby on 17/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "PasswordTextField.h"

@implementation PasswordTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    UIMenuController*menuController = [UIMenuController sharedMenuController];
    
    if(menuController) {
        
        [UIMenuController sharedMenuController].menuVisible=NO;
        
    }
    
    return NO;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
