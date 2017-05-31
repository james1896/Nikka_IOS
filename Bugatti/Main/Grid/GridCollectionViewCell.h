//
//  GridCollectionViewCell.h
//  Bugatti
//
//  Created by toby on 22/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef int(^selectItem)(int flag);

@interface GridCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *count;



- (void)selectItem:(selectItem)selectItem;
@end
