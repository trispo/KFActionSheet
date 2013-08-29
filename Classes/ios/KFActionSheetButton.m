//
//  KFActionSheetButton.m
//  KFActionSheet
//
//  Created by Gunnar Herzog on 27.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFActionSheetButton.h"

@implementation KFActionSheetButton


- (id)init
{
    self = [super init];
    if (self)
    {
        _height = 44.0f;
    }
    return self;
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width, MAX(self.height, size.height));
}


@end
