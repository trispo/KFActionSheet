//
//  KFActionSheetViewController.m
//  Pods
//
//  Created by Gunnar Herzog on 30.09.13.
//
//

#import "KFActionSheetViewController.h"

@interface KFActionSheetViewController ()

@property (nonatomic, strong) UIWindow *keyWindow;

@end


@implementation KFActionSheetViewController

- (instancetype)initWithWindow:(UIWindow *)window
{
    self = [super init];
    if (self)
    {
        self.keyWindow = window;
    }
    return self;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [[UIApplication sharedApplication] statusBarStyle];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return [self.keyWindow.rootViewController supportedInterfaceOrientations];
}

@end
