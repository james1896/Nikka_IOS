//
//  CSTextField.m
//  A02_iPhone
//
//  Created by toby on 28/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "CSTextField.h"

@implementation CSTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tintColor = [UIColor whiteColor];
        self.textColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawPlaceholderInRect:(CGRect)rect
{
    [[self placeholder] drawInRect:rect withAttributes:
                            @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSForegroundColorAttributeName:COLOR(188, 188, 188, 1)}];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGSize size = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGRect placeHolderF = CGRectMake((bounds.size.width - size.width) / 2, 0, size.width, size.height);
    return placeHolderF;
}


@end
