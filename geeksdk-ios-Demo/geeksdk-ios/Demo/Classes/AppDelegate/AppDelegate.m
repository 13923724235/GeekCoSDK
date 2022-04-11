//
//  AppDelegate.m
//  geeksdk-ios
//
//  Created by Jett on 2022/3/15.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "GKIBeaconScanListInfoVC.h"
#import "GKSceneRecognViewController.h"
#import <GeekMXSDK/GeekSDKManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.windowLevel = UIWindowLevelAlert + 1;
    
    [self initRootTabBarVC];
    [self.window makeKeyAndVisible];
    
    [self registerLocalNoti];
    
    return YES;
}

/// SDK正常使用逻辑
- (void)initGeekSDK {
    
    [[GeekSDKManager sharedInstance] initSdkWithCompleted:^(GeekSDKManagerInitStatus status) {
        NSLog(@"status === %ld", status);
    }];
}

- (void)initRootTabBarVC {
 
    UITabBarController *tabBarVc = [[UITabBarController alloc] init];
    if (@available(ios 13.0,*)) {
        UIColor *unselectColor = [UIColor lightGrayColor];
        UIColor *selectColor = [UIColor blueColor];
        
        UITabBarAppearance *appearance = UITabBarAppearance.new;
        NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
        par.alignment = NSTextAlignmentCenter;
        UITabBarItemStateAppearance *normal = appearance.stackedLayoutAppearance.normal;
        if(normal) {
            normal.titleTextAttributes = @{NSForegroundColorAttributeName:unselectColor,NSParagraphStyleAttributeName : par};
        }

        UITabBarItemStateAppearance *selected = appearance.stackedLayoutAppearance.selected;
        if(selected) {
            selected.titleTextAttributes = @{NSForegroundColorAttributeName:selectColor,NSParagraphStyleAttributeName : par};
        }
        tabBarVc.tabBar.standardAppearance = appearance;
    }else {
        UIColor *unselectColor = [UIColor lightGrayColor];
        UIColor *selectColor = [UIColor blueColor];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor} forState:UIControlStateNormal]; // 设置未选中颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor} forState:UIControlStateSelected];
    }
    
    GKIBeaconScanListInfoVC *scanVc = [[GKIBeaconScanListInfoVC alloc] init];
    scanVc.tabBarItem.title = @"IBeacon";
    scanVc.tabBarItem.image = [UIImage systemImageNamed:@"antenna.radiowaves.left.and.right"];

    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:scanVc];
    [tabBarVc addChildViewController:nav1];
    
    GKSceneRecognViewController *recognVc = [[GKSceneRecognViewController alloc] init];
    recognVc.tabBarItem.title = @"Scene";
    recognVc.tabBarItem.image = [UIImage systemImageNamed:@"highlighter"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:recognVc];
    [tabBarVc addChildViewController:nav2];
    
    self.window.rootViewController = tabBarVc;
}

// 注册本地通知
- (void)registerLocalNoti {
    
    if (@available(iOS 10.0, *)) { // iOS10 以上
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    } else {// iOS8.0 以上
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
    
}

#pragma mark - UNUserNotificationCenter

// 在前台时 收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

- (void)application:(UIApplication *)application dideceiRveLocalNotification:(UILocalNotification *)notification {
    
    if (application.applicationState != UIApplicationStateActive) {  //应用不在前台运行
    }
}


// 点击通知，从后台进入前台
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
//    NSString *identifier =  response.actionIdentifier;
    
//    if ([identifier isEqualToString:@"open"]) {
//        NSLog(@"打开操作");
//    } else if ([identifier isEqualToString:@"close"]) {
//        NSLog(@"关闭操作");
//    }
    
    completionHandler();
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
