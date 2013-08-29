//
//  KFActionSheet.h
//  epost
//
//  Created by Gunnar Herzog on 27.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KFActionSheet;

typedef void(^KFActionSheetButtonHandler)(KFActionSheet *actionSheet);

@interface KFActionSheet : UIView

- (void)show;
- (void)addCancelButtonWithTitle:(NSString *)title backgroundImage:(UIImage *)backgroundImage handler:(KFActionSheetButtonHandler)handler;
- (void)addDestructiveButtonWithTitle:(NSString *)title image:(UIImage *)image handler:(KFActionSheetButtonHandler)handler;
- (void)addButtonWithTitle:(NSString *)title image:(UIImage *)image handler:(KFActionSheetButtonHandler)handler;


@end
