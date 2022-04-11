//
//  MBProgressHUD+Geek.m
//  geeksdk-ios
//
//  Created by Jett on 2022/3/16.
//

#import "MBProgressHUD+Geek.h"

@implementation MBProgressHUD (Geek)

#pragma mark - 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont systemFontOfSize:15];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:2.5];
}

#pragma mark - Success && Error

+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark - 显示一些信息

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)showHudAddedTo:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = @"";
    return hud;
}

+ (MBProgressHUD *)showHudAddedTo:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = title;
    return hud;
}

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view afterDelay:(NSTimeInterval)delay {
    if ([message isKindOfClass:[NSNull class]]) {
        message = @"失败";
    }
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabel.text = message;
    hud.userInteractionEnabled = YES;
    [hud hideAnimated:YES afterDelay:delay];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)showWindownHUD {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self showHUDAddedTo:view animated:YES];
}

+ (void)hideWindownHUD {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideAllHUD {
    
    [self hideAllHudForMainQueue];
}

+ (void)hideHudForView:(UIView *)view {
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)hideAllHudForMainQueue {
    
    for (UIView *subview in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subview isKindOfClass:[MBProgressHUD self]]) {
            [MBProgressHUD hideHUDForView:subview animated:YES];
        }
    }
}


@end
