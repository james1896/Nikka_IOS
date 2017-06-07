//
//  MeViewController.m
//  Bugatti
//
//  Created by toby on 11/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"

#import "GiftViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "ThankViewController.h"



@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tabView;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *jifenLab;

@end

@implementation MeViewController


/*  ~~~~~~~~~~~~~~~~~~~~~~~     SET GET 方法      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark SET GET 方法



- (NSArray *)imageArray {
    return @[@"zengsong",@"me_key",@"yijian",@"me_thank",@"about",@"exit"];
}

- (NSArray *)dataArray {
    if(!_dataArray){
        _dataArray = @[@"礼物赠送",@"生活助手",@"意见反馈",@"鸣谢组织",@"关于我们",@"退出账号"];
        
        //礼物赠送 包括积分赠送和礼品赠送
        //礼品赠送 可以选择包装并留言
        
    }
    return _dataArray;
}

- (UITableView *)tabView{
    if(!_tabView){
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT)
                                                style:UITableViewStylePlain];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.tableHeaderView = self.headerView;
        
        UIView *footerView = [[UIView alloc]init];
        UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(41, 0, SCREEN_WIDTH-90, 1)];
        downLine.backgroundColor = COLOR(238, 238, 238, 1);
        [footerView addSubview:downLine];
        _tabView.tableFooterView = footerView;
        _tabView.backgroundColor = [UIColor whiteColor];
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        UIView *bgView = [[UIView alloc]initWithFrame:_tabView.bounds];
        UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"diwen"]];
        bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        
        [bgView addSubview:bgImageView];
        _tabView.backgroundView = bgView;
        
    }
    return _tabView;
}

- (UIView *)headerView {
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 290)];
    _headerView.backgroundColor = [UIColor whiteColor];
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, 0)];
    [bezier addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
    [bezier addLineToPoint:CGPointMake(SCREEN_WIDTH, 225)];
    [bezier addLineToPoint:CGPointMake(0, 175)];
    [bezier addLineToPoint:CGPointMake(0,0)];
    layer.path = bezier.CGPath;
    layer.fillColor = [UIColor pinkColor].CGColor;
    [_headerView.layer addSublayer:layer];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(40, 150,75, 75)];
    [_headerView addSubview:img];
    img.image = [UIImage imageNamed:@"home_banner"];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 5;
    img.layer.borderColor = [UIColor whiteColor].CGColor;
    img.layer.borderWidth = 2;
    
    //    self.name = [UILabel new];
    //    self.name.text = ([userInfoManager shareManager].userName == NULL?@"June":[userInfoManager shareManager].userName);
    //    self.name.font = [UIFont boldSystemFontOfSize:18];
    //    [_headerView addSubview:self.name];
    //    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(img).offset(3);
    //        make.top.equalTo(img).offset(85);
    //    }];
    //
    //    UILabel *content = [UILabel new];
    //    content.font = [UIFont systemFontOfSize:11];
    //    content.text = @"Live for the along";
    //    content.textColor = COLOR(218, 218, 218, 1);
    //    [_headerView addSubview:content];
    
    
    //    [content mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.name).offset(0);
    //        make.top.equalTo(self.name).offset(self.name.height+20);
    //    }];
    self.jifenLab = [[UILabel alloc]initWithFrame:CGRectMake(_headerView.width-170, 193, 132, 20)];
    self.jifenLab.font = [UIFont boldSystemFontOfSize:14];
    self.jifenLab.textColor = [UIColor whiteColor];
    self.jifenLab.textAlignment = NSTextAlignmentRight;
    
    if(IS_IPHONE7PLUS) self.jifenLab.transform = CGAffineTransformMakeRotation(M_PI_2/180*16.5);
    if(IS_IPHONE7) self.jifenLab.transform = CGAffineTransformMakeRotation(M_PI_2/180*17);
    if(IS_IPHONE5){
        self.jifenLab.frame =CGRectMake(_headerView.width-158, 191, 120, 20);
        self.jifenLab.transform = CGAffineTransformMakeRotation(M_PI_2/180*18);
    }
    
    [_headerView addSubview:self.jifenLab];
    
    
    
    return _headerView;
}

/*  ~~~~~~~~~     TableViewDelegate & TableViewdatasource      ~~~~~~~~~~~~~~~~~~   */

#pragma mark - TableViewDelegate & TableViewdatasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(!self.dataManager.isLogin) return self.dataArray.count-1;
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeTableViewCell *cell = (MeTableViewCell *)[UITableViewCell initNibName:@"MeTableViewCell"];
    cell.title.text = self.dataArray[indexPath.row];
    cell.icon.image = [UIImage imageNamed:[self imageArray][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.dataArray.count-1){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:
                                              self.userInfo.userName message:@"你确定要退出当前账号吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.dataManager resetUserInfo];
            //            tableView.tableHeaderView = self.headerView;
            self.subtitleName = @"";
            self.jifenLab.text = @"";
            [tableView reloadData];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
        
    }else{
        BaseViewController *controller = nil;
        switch (indexPath.row) {
            case 0:
                //礼物转赠
                controller = [GiftViewController new];
                
                break;
            case 1:
                //生活助手
                
                
                break;
            case 2:
                //反馈
                controller = [[FeedbackViewController alloc]init];
                break;
            case 3:
                //感谢
                [self.navigationController pushViewController:[[ThankViewController alloc]init] animated:YES];
                
                return;
            case 4:
                //关于
                [self.navigationController pushViewController:[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil] animated:YES];
                
                return;
                
            default:
                self.subtitleName = @"";
                break;
        }
        if(controller)
            [self.baseTabbarController showLoginControllerWithDesiredController:controller];
    }
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     lift cycle      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark - lift cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    if(self.dataManager.isLogin){
        
        
        [TBRuquestManager updatePointsWithUserID:self.userInfo.user_id
                                        positive:0
                                        negative:0
                                         success:^(NSURLSessionDataTask *task,
                                                   id responseObject) {
                                             
                                             if([responseObject dataFormatIsRight]){
                                                 
                                                 if([responseObject isTrueCode]){
                                                     self.userInfo.moneyPoints = [[responseObject getPointsInData] floatValue];
                                                     self.jifenLab.text = [NSString stringWithFormat:@"当前积分: %.2f",self.userInfo.moneyPoints];
                                                 }
                                             }
                                         }
                                         failure:^(NSURLSessionDataTask *task,
                                                   NSError *error) {
                                             
                                         }
         ];
        
        self.subtitleName = (self.userInfo.userName == NULL?@"":self.userInfo.userName);
        self.jifenLab.text = [NSString stringWithFormat:@"当前积分: %.2f",self.userInfo.moneyPoints];
        [self.tabView reloadData];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tabView];
    self.titleName = @"Profile";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)COLOR(67, 223, 255, 1).CGColor,(__bridge id)COLOR(55, 142, 255, 1).CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    gradientLayer.locations = @[@0.4,@1];
    return gradientLayer;
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
