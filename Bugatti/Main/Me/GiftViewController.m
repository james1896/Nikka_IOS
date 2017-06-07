//
//  GiftViewController.m
//  Bugatti
//
//  Created by toby on 05/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "GiftViewController.h"
#import "GiftTableViewCell.h"
#import "CSTextField.h"


typedef enum {
    GiftViewTypePoints,
    GiftViewTypeApple
}GiftViewType;

@interface GiftView : UIView

@property (nonatomic)GiftViewType giftType;

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UITextField *userName;
@property (nonatomic,strong) UITextField *content;
@property (nonatomic,strong) UILabel *availablePointsLab;

@property (nonatomic,strong) UIButton *confirmBtn;

- (void)confirmButtonAddTarget:(id)target action:(SEL)action;

- (void)refreshView;
@end

@implementation GiftView

- (instancetype)init{
    if(self = [super init]){
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = COLOR(0, 0, 0, 0.4);
        [self addSubview:self.contentView];
        UIButton *back = [UIButton createWhiteBackButtonWithTarget:self action:@selector(backbutton:)];
        [self addSubview:back];
        
        
    }
    return self;
}

- (void)confirmButtonAddTarget:(id)target action:(SEL)action{
    [self.confirmBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setGiftType:(GiftViewType)giftType{
    switch (giftType) {
        case GiftViewTypePoints:{
            self.content.placeholder =  @"转赠积分数量";
            break;
        }
            
        case GiftViewTypeApple:{
            self.content.placeholder = @"你想送朋友几颗苹果？";
            break;
        }
            
        default:
            break;
    }
}

- (void)refreshView{
    
    self.userName.text = @"";
    self.content.text = @"";
    self.availablePointsLab.text = [NSString stringWithFormat:@"可用积分:%.2f",
                                    [NKAppManager shareManager].userInfo.moneyPoints];
}

- (UILabel *)availablePointsLab{
    if(!_availablePointsLab){
        _availablePointsLab = [[UILabel alloc]initWithFrame:CGRectMake(self.userName.left, self.userName.bottom+20, self.userName.width, 20)];
        _availablePointsLab.textAlignment = NSTextAlignmentRight;
        _availablePointsLab.font = [UIFont systemFontOfSize:14];
        _availablePointsLab.textColor = [UIColor pinkColor];
        
    }
    
    return _availablePointsLab;
}

- (UIButton *)confirmBtn{
    if(!_confirmBtn){
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"立即转赠" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:[UIColor pinkColor]];
        _confirmBtn.layer.cornerRadius = 3;
        _confirmBtn.frame = CGRectMake(self.userName.left, self.content.bottom+60, self.userName.width, 40);
    }
    return _confirmBtn;
}

-(UITextField *)userName{
    if(!_userName){
        _userName = [[CSTextField alloc]initWithFrame:
                     CGRectMake(20, _contentView.height/2-40 - 80, self.contentView.width-40, 45)];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.placeholder = @"好友用户名";
        _userName.layer.borderWidth = 1;
        _userName.layer.cornerRadius = 3;
        _userName.textColor = COLOR(51, 51, 51, 1);
        _userName.layer.borderColor = COLOR(178, 178, 178, 0.8).CGColor;
    }
    return _userName;
}

- (UITextField *)content{
    if(!_content){
        _content =  [[CSTextField alloc]initWithFrame:
                     CGRectMake(20, self.availablePointsLab.bottom+5, self.contentView.width-40, 45)];
        _content.textAlignment = NSTextAlignmentCenter;
        _content.layer.borderWidth = 1;
        _content.keyboardType = UIKeyboardTypePhonePad;
        _content.layer.cornerRadius = 3;
        _content.textColor = COLOR(51, 51, 51, 1);
        _content.layer.borderColor = COLOR(178, 178, 178, 0.8).CGColor;
    }
    return _content;
}

- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc]initWithFrame:
                        CGRectMake(0, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT-300)];
        _contentView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        _contentView.backgroundColor = [UIColor whiteColor];
        
        
        [_contentView addSubview:self.userName];
        [_contentView addSubview:self.availablePointsLab];
        [_contentView addSubview:self.content];
        [_contentView addSubview:self.confirmBtn];
    }
    return _contentView;
}

- (void)backbutton:(UIButton *)sender {
    [self removeFromSuperview];
}

@end

@interface GiftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) GiftView *pointView;
@property (nonatomic,strong) GiftView *appleView;
@end


@implementation GiftViewController

- (GiftView *)pointView{
    if(!_pointView){
        _pointView = [[GiftView alloc]init];
        _pointView.giftType = GiftViewTypePoints;
        [_pointView confirmButtonAddTarget:self action:@selector(pointBtnPress:)];
    }
    return _pointView;
}

- (GiftView *)appleView{
    if(!_appleView){
        _appleView = [[GiftView alloc] init];
        _appleView.giftType = GiftViewTypeApple;
    }
    return _appleView;
}

- (void)pointBtnPress:(UIButton *)sender {
    
    NSInteger points = [self.pointView.content.text intValue];
    [TBRuquestManager transformPointWithUserID:self.userInfo.user_id
                                    friendName:self.pointView.userName.text
                                         point:points
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           
                                           
                                           if([responseObject isTrueCode]){
                                               self.userInfo.moneyPoints = self.userInfo.moneyPoints - points;
                                               
                                               
                                               [self.pointView removeFromSuperview];
                                               [TBToastView showToastViewWithText:[NSString stringWithFormat:@"您成功赠送给 %@ %ld积分，赶快通知他吧!",
                                                                                   self.pointView.userName.text,[self.pointView.content.text integerValue]]
                                                                       completion:^{
                                                                           
                                                                       }];
                                               
                                           }else if([[responseObject getStatusCodeInData] isEqualToNumber:@(711)]){
                                               [TBToastView showToastViewWithText:@"请确认，转赠人用户名是否正确"];
                                           }
                                       }
     
                                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }
     ];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = @[@"积分转赠",@"苹果赠送"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"Gift To";
    self.navbarBackgroundColor = [UIColor pinkColor];
    [self addPinkBackbutton];
    
    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftTableViewCell *cell = (GiftTableViewCell *)[UITableViewCell initNibName:@"GiftTableViewCell"];
    cell.textLabel.textColor = [UIColor pinkColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
        if(!self.pointView.superview){
            [self.pointView refreshView];
            [self.navigationController.view addSubview:self.pointView];
        }
        
    }else if (indexPath.row == 1){
        if(!self.appleView.superview){
            [self.appleView refreshView];
            [self.navigationController.view addSubview:self.appleView];
        }
        
    }
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
