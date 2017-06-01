//
//  ThankOrganizationViewController.m
//  Bugatti
//
//  Created by toby on 31/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "ThankViewController.h"

@interface ThankViewController ()

@property (nonatomic,strong) UILabel *labView;

@end

@implementation ThankViewController

- (UILabel *)labView{
    if(!_labView){
        _labView = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_PACE, NAV_BOTTOM+10, self.view.width-VIEW_PACE*2,180)];
        _labView.numberOfLines = 0;
        _labView.textColor = [UIColor whiteColor];
    }
    return _labView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor pinkColor];
    self.titleName = @"Thank For";
//    self.titleAlignment = NavTitleAlignmentLeftEdge;
    [self.view addSubview:self.labView];
    [self addGrayBackbutton];
    
    self.labView.attributedText = [@"感谢以下开源组织提供技术支持：\n Masonry  \n AFNetworking \n IQKeyboardManager \n ShareSDK3 \n" lineSpacingWithSpace:6];
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
