//
//  KFActionSheet.m
//  KFActionSheet
//
//  Created by Gunnar Herzog on 27.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFActionSheet.h"
#import "KFActionSheetButton.h"
#import "KFActionView.h"


@interface KFActionSheet ()


@property (strong, nonatomic) NSMutableDictionary *buttonActionHandlers;

@property (strong, nonatomic) NSLayoutConstraint *actionSheetBottomConstraint;

@property (strong, nonatomic) KFActionView *actionView;

@property (strong, nonatomic) UIView *backgroundView;

@property (nonatomic, strong) UIWindow *oldKeyWindow;

@property (strong, nonatomic) UIWindow *actionSheetWindow;

@property (nonatomic) BOOL isVisible;


@end


@implementation KFActionSheet

- (id)init
{
    self = [super init];
    if (self)
    {
        self.buttonActionHandlers = [NSMutableDictionary dictionary];
        [self createBackgroundView];
        [self createActionView];
        
        _animationDuration = .3f;
    }
    return self;
}


- (void)createBackgroundView
{
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.backgroundView];

    NSDictionary *views = @{@"background":self.backgroundView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[background]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[background]|" options:0 metrics:nil views:views]];
}


- (void)createActionView
{
    self.actionView = [KFActionView new];
    self.actionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.actionView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:@{@"view":self.actionView}]];
    self.actionSheetBottomConstraint = [NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];

    [self addConstraint:self.actionSheetBottomConstraint];
}


- (void)buttonAction:(UIButton *)sender
{
    KFActionSheetButtonHandler handler = self.buttonActionHandlers[sender.currentTitle];
    
    __weak KFActionSheet *weakSelf = self;
    self.actionSheetBottomConstraint.constant = [self.actionView intrinsicContentSize].height;
    [UIView animateWithDuration:self.animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
    {
        weakSelf.backgroundView.alpha = 0;
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished)
    {
        [weakSelf.actionSheetWindow removeFromSuperview];
        [weakSelf removeFromSuperview];

        if (handler != nil)
        {
            handler(weakSelf);
        }
        
        if (finished)
        {
            self.isVisible = NO;
        }
    }];
}


- (KFActionSheetButton *)addDestructiveButtonWithTitle:(NSString *)title image:(UIImage *)image handler:(KFActionSheetButtonHandler)handler
{
    KFActionSheetButton *button = [self buttonWithTitle:title image:image handler:handler];
    [button setTitleColor:[UIColor colorWithRed:0.887 green:0.159 blue:0.123 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.908 green:0.166 blue:0.141 alpha:1.000] forState:UIControlStateHighlighted];
    
    if (handler != nil)
    {
        self.buttonActionHandlers[title] = [handler copy];
    }

    [self.actionView addButton:button];
    return button;
}


- (KFActionSheetButton *)addButtonWithTitle:(NSString *)title image:(UIImage *)image handler:(KFActionSheetButtonHandler)handler
{
    KFActionSheetButton *button = [self buttonWithTitle:title image:image handler:handler];
    [button setTitleColor:[UIColor colorWithWhite:0.200 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
    [self.actionView addButton:button];
    return button;
}


- (KFActionSheetButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image handler:(KFActionSheetButtonHandler)handler
{
    KFActionSheetButton *button = [KFActionSheetButton new];
    [button setBackgroundImage:[[UIImage imageNamed:@"actionsheet-default-button-background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"actionsheet-default-button-background-highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forState:UIControlStateHighlighted];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 65, 0, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:17];

    if (image != nil)
    {
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    }

    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    if (handler != nil)
    {
        self.buttonActionHandlers[title] = [handler copy];
    }

    return button;
}


- (KFActionSheetButton *)addCancelButtonWithTitle:(NSString *)title backgroundImage:(UIImage *)backgroundImage handler:(KFActionSheetButtonHandler)handler
{
    KFActionSheetButton *cancelButton = [KFActionSheetButton new];
    [cancelButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [cancelButton setTitle:title forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [cancelButton setTitleColor:[UIColor colorWithWhite:0.200 alpha:1.000] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    if (handler != nil)
    {
        self.buttonActionHandlers[title] = [handler copy];
    }

    [self.actionView addCancelButton:cancelButton];
    
    return cancelButton;
}


- (void)show
{
    if (self.isVisible)
    {
        return;
    }
    
    self.oldKeyWindow = [[UIApplication sharedApplication] keyWindow];

    self.frame = self.oldKeyWindow.bounds;

    if (self.actionSheetWindow == nil)
    {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        self.actionSheetWindow = window;
    }

    self.actionSheetBottomConstraint.constant = [self.actionView intrinsicContentSize].height;
    [self layoutIfNeeded];

    [self.actionSheetWindow addSubview:self];
    [self.actionSheetWindow makeKeyAndVisible];

    self.backgroundView.alpha = 0;
    self.actionSheetBottomConstraint.constant = 0;

    __weak KFActionSheet *weakSelf = self;
    [UIView animateWithDuration:self.animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
    {
        weakSelf.backgroundView.alpha = 1;
        [weakSelf layoutIfNeeded];

    } completion:nil];

    [self.oldKeyWindow makeKeyWindow];
    self.oldKeyWindow.hidden = NO;
}

@end
