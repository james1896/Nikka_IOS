//
//  AmaenboController.m
//  Bugatti
//
//  Created by toby on 01/06/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "AmaenboController.h"

@interface AmaenboController ()

@end

@implementation AmaenboController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"亲 !";
    self.navbarBackgroundColor = [UIColor colortThemeGreen];
    [self addGrayBackbutton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
