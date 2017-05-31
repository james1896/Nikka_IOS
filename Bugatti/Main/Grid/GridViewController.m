//
//  GridViewController.m
//  Bugatti
//
//  Created by toby on 16/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "GridViewController.h"
#import "GridCollectionViewCell.h"


@interface CashierDesk : UIView

- (void)updateCashierDesk:(CGFloat)point;

- (instancetype)initWithFrame:(CGRect)frame point:(CGFloat)point;

@property (nonatomic,strong) UILabel *moneyLab;
@end
@implementation CashierDesk

- (instancetype)initWithFrame:(CGRect)frame point:(CGFloat)point
{
    self = [super initWithFrame:frame];
    if (self) {
        _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width-15, self.height)];
        _moneyLab.textColor = [UIColor whiteColor];
        _moneyLab.textAlignment = NSTextAlignmentRight;
        _moneyLab.font = [UIFont boldSystemFontOfSize:16];
        _moneyLab.text = [NSString stringWithFormat:@"剩余积分: %.2f",point];
         [self addSubview:_moneyLab];
    }
    return self;
}


- (void)updateCashierDesk:(CGFloat)point{
    self.moneyLab.text = [NSString stringWithFormat:@"剩余积分: %.2f",point];
}

@end


@interface GridViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) CashierDesk *cashierDesk;

@end

@implementation GridViewController

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (CashierDesk *)cashierDesk{
    if(!_cashierDesk){
        NSLog(@"cash:%.2f",self.userData.moneyPoints);
        _cashierDesk = [[CashierDesk alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-25*2, 50) point:self.userData.moneyPoints];
    }
   
    return _cashierDesk;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.cashierDesk updateCashierDesk:self.userData.moneyPoints];
    
    NSLog(@"gridController:%@",self.navigationController);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //紫色
    self.view.backgroundColor = COLOR(128, 89, 247, 1);
    //蓝色
//        self.view.backgroundColor = COLOR(67, 89, 247, 1);
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont boldSystemFontOfSize:17];
    titleLab.text = @"NIKKA";
    [self.view addSubview:titleLab];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    //设置每个item的大小为100*100
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(25, 50, SCREEN_WIDTH-25*2, SCREEN_HEIGHT-55*2)];
    
     CGFloat itemWidth = (bgView.width -15*3 - 20)/2;
    CGFloat itemHeight = (bgView.height - 40-60)/3;
    //    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    //创建collectionView 通过一个布局策略layout来创建
    
    //红色＋黄色
    [bgView.layer addSublayer:[self backgroundLayerWithFrame:bgView.bounds colors:@[(__bridge id)COLOR(228, 68, 78,1).CGColor,(__bridge id)COLOR(233, 115, 79, 1).CGColor,(__bridge id)COLOR(243, 196, 88, 1).CGColor]]];
    
    //浅蓝＋草绿
//     [bgView.layer addSublayer:[self backgroundLayerWithFrame:bgView.bounds colors:@[(__bridge id)COLOR(100, 201, 235,1).CGColor,(__bridge id)COLOR(151, 216, 148, 1).CGColor,(__bridge id)COLOR(215, 242, 100, 1).CGColor]]];
    
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
   
    
    UICollectionView * collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH-25*2, SCREEN_HEIGHT-55*2-40) collectionViewLayout:layout];
    collect.showsHorizontalScrollIndicator = NO;
    collect.backgroundColor = [UIColor clearColor];
    
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    
    //注册item类型 这里使用系统的类型
    
   
    [collect registerNib:[UINib nibWithNibName:@"GridCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [bgView addSubview:collect];
     [bgView addSubview:self.cashierDesk];
    [self.view addSubview:bgView];
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GridCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];

    NSDictionary *dict = [self dataDict][indexPath.row];
    cell.bgImgView.image = [UIImage imageNamed:dict[@"img"]];
    
    //iphone5 title 显示不完整问题
    cell.title.font = (IS_IPHONE5? [UIFont systemFontOfSize:11]:[UIFont systemFontOfSize:14]);
    cell.title.text = dict[@"title"];
    
    [cell selectItem:^int(int flag) {
        
        CGFloat price = [dict[@"price"] floatValue];
        if(flag == 0){
        //＋＋

            if(self.userData.moneyPoints >= price){
                self.userData.moneyPoints -= price;
                   [self.cashierDesk updateCashierDesk:self.userData.moneyPoints];
                return 0;
            }
        }else{
        //---
            self.userData.moneyPoints += price;
               [self.cashierDesk updateCashierDesk:self.userData.moneyPoints];
            return 1;
        }
        return -1;
    }];

    return cell;
}

- (NSArray *)dataDict{
    return @[@{@"img":@"img01.jpeg" ,@"title":@"洗衣服 4积分/袋"  ,@"price":@(4)},
             @{@"img":@"img02.jpeg" ,@"title":@"牙刷 3.5积分/只"  ,@"price":@(3.5)},
             @{@"img":@"img03.jpg"  ,@"title":@"毛巾 8.8积分/条"  ,@"price":@(8.8)},
             @{@"img":@"img04.jpeg" ,@"title":@"鲜榨果汁 7积分/杯" ,@"price":@(7)},
             @{@"img":@"img05.jpg"  ,@"title":@"葡萄 1积分/3两"   ,@"price":@(1)},
             @{@"img":@"img06.jpg"  ,@"title":@"大樱桃 2积分/1两"  ,@"price":@(2)},
             @{@"img":@"img07.jpg"  ,@"title":@"定制T恤 28积分/件" ,@"price":@(28)},
             @{@"img":@"img08.jpeg" ,@"title":@"冲洗照片 3积分/版"  ,@"price":@(3)},
             @{@"img":@"img09.jpeg" ,@"title":@"盆栽 19积分/盆"    ,@"price":@(19)},
             @{@"img":@"img10.jpeg" ,@"title":@"打印 0.1积分/张"   ,@"price":@(0.1)}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CAGradientLayer *)backgroundLayerWithFrame:(CGRect)frame colors:(NSArray *)colors{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.2,@0.6,@1];
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
