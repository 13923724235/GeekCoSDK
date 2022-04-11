//
//  MBProgressHUD+Geek.h
//  geeksdk-ios
//
//  Created by Jett on 2022/3/16.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Geek)

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view afterDelay:(NSTimeInterval)delay;

+ (MBProgressHUD *)showHudAddedTo:(UIView *)view;

+ (MBProgressHUD *)showHudAddedTo:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;

/// Windown显示HUD
+(void)showWindownHUD;

/// Windown隐藏HUD
+ (void)hideWindownHUD;

/// 隐藏当前窗口所有HUD
+ (void)hideAllHUD;

/// 隐藏制定窗口的HUD
+ (void)hideHudForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
