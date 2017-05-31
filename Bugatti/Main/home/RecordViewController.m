//
//  RecordViewController.m
//  Bugatti
//
//  Created by toby on 21/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordTableViewCell.h"
#import <Accounts/Accounts.h>

static CGFloat cell_height = 60;

NSString *name = @"name";
NSString *time1 = @"time";
NSString *price = @"price";

@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UITableView *tab;
@end

@implementation RecordViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}
- (NSArray *)dataArray {
    if(!_dataArray){
       
    }
    return _dataArray;
}

+ (void)load{
    NSLog(@"RecordViewController load");
}

+ (void)initialize{
    NSLog(@"RecordViewController initialize");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addWhiteBackbutton];
    self.backgroundImage = [UIImage imageNamed:@"dabenzhong"];
    
    
    
    self.tab = [[UITableView alloc] initWithFrame:
                                            CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-49-20)
                                            style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
    self.tab.backgroundColor = [UIColor clearColor];
    
   self.tab.frame = CGRectMake(0, 20, SCREEN_WIDTH, (cell_height*self.dataArray.count>SCREEN_HEIGHT -20-45?SCREEN_HEIGHT -20-45:cell_height*self.dataArray.count));
//    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [TBRuquestManager queryOrderWithUserID:@"14949025190" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = responseObject;
        self.dataArray =dict[@"data"];
        self.tab.frame = CGRectMake(0, 20, SCREEN_WIDTH, (cell_height*self.dataArray.count>SCREEN_HEIGHT -20-45?SCREEN_HEIGHT -20-45:cell_height*self.dataArray.count));
           [self.tab reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cell_height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"RecordTableViewCell"  owner:self options:nil] lastObject];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    if ([[dict allKeys]  containsObject: name]){
        cell.nameLab.text = dict[name];
        cell.time.text = dict[time1];
        cell.moneyLab.text = [NSString stringWithFormat:@"￥%@",dict[price]];
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
