//
//  AboutViewController.m
//  Bugatti
//
//  Created by toby on 18/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *downloadLab;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"About us";
    self.navbarBackgroundColor = [UIColor pinkColor];
    [self addPinkBackbutton];
    
    self.downloadLab.text = @"      IOS  下载:    APP Store \n Android下载:";
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
