//
//  MeTableViewCell.h
//  Bugatti
//
//  Created by toby on 21/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
