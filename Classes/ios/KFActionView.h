//
//  KFActionView.h
//  KFActionSheet
//
//  Created by Gunnar Herzog on 27.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFActionView : UIView

- (void)addCancelButton:(UIButton *)cancelButton;
- (void)addButton:(UIButton *)button;

@end
