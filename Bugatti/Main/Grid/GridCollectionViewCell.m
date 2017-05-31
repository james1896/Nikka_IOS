//
//  GridCollectionViewCell.m
//  Bugatti
//
//  Created by toby on 22/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "GridCollectionViewCell.h"


@interface GridCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;

@property (nonatomic,strong) selectItem selectItem;

@property (nonatomic)  NSInteger number;

@end
@implementation GridCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
     UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
  
    [self.upView addGestureRecognizer:tap1];
    [self.downView addGestureRecognizer:tap2];
 
}

- (void)tap:(UITapGestureRecognizer *)tap {

    int flag = (int)tap.view.tag;
    UIView *tmpView = tap.view;
    NSArray *imgArray = @[@"grid_add",@"grid_sub"];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgArray[flag]]];
    img.frame = CGRectMake(tmpView.width/2-15, tmpView.height/2-15, 30, 30);
    img.hidden = YES;
    [tmpView addSubview:img];
    [UIView animateWithDuration:0.6 animations:^{
        img.hidden = NO;
          tmpView.backgroundColor = COLOR(0, 0, 0, 0.5);
    
    } completion:^(BOOL finished) {
        tmpView.backgroundColor = [UIColor clearColor];
        [img removeFromSuperview];
    }];
    
    if((self.number == 0 && flag == 1) || self.number < 0){
    //点击了 减号
    //但是已选择的数量为0
        
    //  number < 0 标示异常
        return;
    }
    
    NSInteger i = _selectItem(flag);
    if( i== 0){
    //++
        self.count.text = [NSString stringWithFormat:@"%ld",++self.number];
    }else if(i==1){
    //---
        if(--self.number == 0){
        self.count.text = @"";
              return;
        }
        self.count.text = [NSString stringWithFormat:@"%ld",self.number];
    }
}

- (void)selectItem:(selectItem)selectItem{
    _selectItem = selectItem;
}

@end
