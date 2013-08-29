//
//  KFActionSheetButton.m
//  epost
//
//  Created by Gunnar Herzog on 27.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFActionSheetButton.h"

@implementation KFActionSheetButton

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width, MAX(44, size.height));
}

@end
