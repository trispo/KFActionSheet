//
//  KFActionView.m
//  epost
//
//  Created by Gunnar Herzog on 27.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFActionView.h"
#import <QuartzCore/QuartzCore.h>

@interface KFActionView ()

@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) NSMutableArray *buttons;

@end


@implementation KFActionView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.buttons = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, -1);
        self.layer.shadowRadius = 8;
        self.layer.shadowOpacity = 0.35;
    }
    return self;
}


- (void)updateConstraints
{
    [super updateConstraints];

    if (self.cancelButton != nil)
    {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(57)-[cancelButton]-(57)-|" options:0 metrics:nil views:@{@"cancelButton":self.cancelButton}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelButton]-(23)-|" options:0 metrics:nil views:@{@"cancelButton":self.cancelButton}]];
    }

    UIButton *lastButton = self.cancelButton;
    
    for (UIButton *button in [[self.buttons reverseObjectEnumerator] allObjects])
    {
        NSDictionary *views = @{@"cancelButton":self.cancelButton, @"button":button};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[button]|" options:0 metrics:nil views:views]];
        
        if (lastButton == self.cancelButton)
        {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-(23)-[cancelButton]-(23)-|" options:0 metrics:nil views:views]];
        }
        else if (lastButton == nil)
        {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[button]-(23)-|" options:0 metrics:nil views:views]];
        }
        else
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:lastButton attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        }
        lastButton = button;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}


- (void)addButton:(UIButton *)button
{
    [self.buttons addObject:button];
    [self addSubview:button];

    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}


- (void)addCancelButton:(UIButton *)cancelButton
{
    if (self.cancelButton != nil)
    {
        return;
    }

    [self addSubview:cancelButton];
    self.cancelButton = cancelButton;

    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];

}


- (CGSize)intrinsicContentSize
{
    CGFloat height = 0;
    for (UIView *button in self.subviews)
    {
        CGFloat buttonHeight = [button intrinsicContentSize].height;
        if (button == self.cancelButton)
        {
            buttonHeight += 46;
        }
        height += buttonHeight;
    }

    return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

@end
