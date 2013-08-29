//
//  KFViewController.m
//  KFActionSheet
//
//  Created by Gunnar Herzog on 29.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFViewController.h"
#import <KFActionSheet/KFActionSheet.h>


@implementation KFViewController

#pragma mark - Actions

- (IBAction)showActionSheet:(id)sender
{
    KFActionSheet *actionSheet = [KFActionSheet new];

    UIImage *backgroundImage = [[UIImage imageNamed:@"button-default"] resizableImageWithCapInsets:UIEdgeInsetsMake(17,5,14,6)];

    [actionSheet addButtonWithTitle:NSLocalizedString(@"Logout", nil) image:[UIImage imageNamed:@"logout-icon"] handler:^(KFActionSheet *actionSheet)
    {
        NSLog(@"Logout action handler called.");
    }];

    [actionSheet addButtonWithTitle:NSLocalizedString(@"Change account", nil) image:[UIImage imageNamed:@"account-icon"] handler:^(KFActionSheet *actionSheet)
    {
        NSLog(@"Change account action handler called.");
    }];

    [actionSheet addCancelButtonWithTitle:NSLocalizedString(@"Cancel", nil) backgroundImage:backgroundImage handler:^(KFActionSheet *actionSheet) {
        NSLog(@"Cancel action handler called.");
    }];
    
    [actionSheet show];
}

@end
