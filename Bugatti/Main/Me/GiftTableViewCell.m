//
//  GiftTableViewCell.m
//  Bugatti
//
//  Created by toby on 05/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "GiftTableViewCell.h"

@implementation GiftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
