//
//  KFActionSheet.h
//  KFActionSheet
//
//  Created by Gunnar Herzog on 27.08.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KFActionSheet;
@class KFActionSheetButton;

typedef void(^KFActionSheetButtonHandler)(KFActionSheet *actionSheet);

@interface KFActionSheet : UIView

- (void)show;
- (KFActionSheetButton *)addCancelButtonWithTitle:(NSString *)title backgroundImage:(UIImage *)backgroundImage handler:(KFActionSheetButtonHandler)handler;
- (KFActionSheetButton *)addDestructiveButtonWithTitle:(NSString *)title image:(UIImage *)image handler:(KFActionSheetButtonHandler)handler;
- (KFActionSheetButton *)addButtonWithTitle:(NSString *)title image:(UIImage *)image handler:(KFActionSheetButtonHandler)handler;


@end
