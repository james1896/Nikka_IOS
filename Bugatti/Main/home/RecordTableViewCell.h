//
//  RecordTableViewCell.h
//  Bugatti
//
//  Created by toby on 21/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
