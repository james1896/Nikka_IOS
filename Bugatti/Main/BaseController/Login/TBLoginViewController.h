//
//  TBLoginViewController.h
//  Bugatti
//
//  Created by toby on 28/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "BaseViewController.h"

@protocol TBLoginViewControllerDelegate;

@interface TBLoginViewController : BaseViewController

@property (nonatomic,strong) id<TBLoginViewControllerDelegate> delegate;

@end

@protocol TBLoginViewControllerDelegate <NSObject>

- (void)loginSuccessedController:(TBLoginViewController *)login;

@end
