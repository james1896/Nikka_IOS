//
//  BaseNavigationController.m
//  Bugatti
//
//  Created by toby on 16/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController



/*  ~~~~~~~~~~~~~~~~~~~~~~~     lift cycle      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark - lift cycle

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        self.navigationBar.translucent = YES;
        UIColor *color = [UIColor clearColor];
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.clipsToBounds = YES;
        self.navigationBar.hidden = YES;
    }
    
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
