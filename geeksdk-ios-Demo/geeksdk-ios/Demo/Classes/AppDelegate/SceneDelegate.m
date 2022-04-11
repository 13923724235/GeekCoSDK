//
//  SceneDelegate.m
//  geeksdk-ios
//
//  Created by Jett on 2022/3/15.
//

#import "SceneDelegate.h"
#import "GKIBeaconScanListInfoVC.h"
#import "GKSceneRecognViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    if (scene) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.frame = [UIScreen mainScreen].bounds;
        self.window.backgroundColor = [UIColor whiteColor];
        [self initRootTabBarVC];
        [self.window makeKeyAndVisible];
        
        [UIApplication sharedApplication].delegate.window = self.window;
    }
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
        
    }else{
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

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
