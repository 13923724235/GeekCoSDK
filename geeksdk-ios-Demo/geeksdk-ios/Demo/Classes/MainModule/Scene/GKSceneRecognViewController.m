//
//  GKSceneRecognViewController.m
//  GeekSDKDemo
//
//  Created by xiaowu on 2022/3/25.
//

#import "GKSceneRecognViewController.h"
#import <GeekMXSDK/GeekSDKManager.h>
#import "Masonry.h"

@interface GKSceneRecognViewController ()

@property (nonatomic, strong) UIButton *sdkBtn;
@property (nonatomic, strong) UIButton *startSceneBtn;
@property (nonatomic, strong) UIButton *endSceneBtn;
@property (nonatomic, strong) UIButton *reseleBtn;
@property (nonatomic, strong) UIButton *upLoadBtn;
@end

@implementation GKSceneRecognViewController

#pragma mark - getter

- (UIButton *)sdkBtn {
    
    if (!_sdkBtn) {
        _sdkBtn = [[UIButton alloc] init];
        _sdkBtn.backgroundColor = [UIColor redColor];
        [_sdkBtn setTitle:@"初始化SDK" forState:UIControlStateNormal];
        [_sdkBtn addTarget:self action:@selector(initBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sdkBtn;
}

- (UIButton *)startSceneBtn {
    
    if (!_startSceneBtn) {
        _startSceneBtn = [[UIButton alloc] init];
        _startSceneBtn.backgroundColor = [UIColor redColor];
        [_startSceneBtn setTitle:@"开始场景识别" forState:UIControlStateNormal];
        [_startSceneBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startSceneBtn;
}

- (UIButton *)endSceneBtn {
    
    if (!_endSceneBtn) {
        _endSceneBtn = [[UIButton alloc] init];
        _endSceneBtn.backgroundColor = [UIColor redColor];
        [_endSceneBtn setTitle:@"结束场景识别" forState:UIControlStateNormal];
        [_endSceneBtn addTarget:self action:@selector(endClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endSceneBtn;
}

- (UIButton *)reseleBtn {
    
    if (!_reseleBtn) {
        _reseleBtn = [[UIButton alloc] init];
        _reseleBtn.backgroundColor = [UIColor redColor];
        [_reseleBtn setTitle:@"释放SDK" forState:UIControlStateNormal];
        [_reseleBtn addTarget:self action:@selector(reseleSDK) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reseleBtn;
}

- (UIButton *)upLoadBtn {
    
    if (!_upLoadBtn) {
        _upLoadBtn = [[UIButton alloc] init];
        _upLoadBtn.backgroundColor = [UIColor redColor];
        [_upLoadBtn setTitle:@"上传反馈日志" forState:UIControlStateNormal];
        [_upLoadBtn addTarget:self action:@selector(upLoadLogClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upLoadBtn;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Scene";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubview];
}

- (void)setupSubview {
    
    [self.view addSubview:self.sdkBtn];
    [self.view addSubview:self.startSceneBtn];
    [self.view addSubview:self.endSceneBtn];
    [self.view addSubview:self.reseleBtn];
    [self.view addSubview:self.upLoadBtn];
    
    [self.sdkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    
    [self.startSceneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sdkBtn.mas_bottom).offset(25);
        make.width.height.equalTo(self.sdkBtn);
        make.centerX.equalTo(self.view);
    }];
    
    [self.endSceneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startSceneBtn.mas_bottom).offset(25);
        make.width.height.equalTo(self.sdkBtn);
        make.centerX.equalTo(self.view);
    }];
    
    [self.reseleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endSceneBtn.mas_bottom).offset(25);
        make.width.height.equalTo(self.sdkBtn);
        make.centerX.equalTo(self.view);
    }];
    
    [self.upLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reseleBtn.mas_bottom).offset(25);
        make.width.height.equalTo(self.sdkBtn);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - SDK Useg

//初始化SDK
- (void)initBtnClick {
    
    [GeekSDKManager sharedInstance].isIBeaconLog = YES;
    
    // 初始化结果回调
    [[GeekSDKManager sharedInstance] initSdkWithCompleted:^(GeekSDKManagerInitStatus status) {
        NSString *tipStr = status == GeekSDKManagerInitStatusSuccess ? @"注册成功":@"注册失败";
        [self showAlertWithTitle:@"" message:tipStr];
    }];
}

//开始场景识别
- (void)startClick {
    
    [[GeekSDKManager sharedInstance] startSceneRecognitionWithCompleted:^(GeekSDKDisernStatus status, NSString * _Nonnull jsonResult) {
        if (status == GeekSDKDisernStatusSuccess) {
            NSLog(@"场景识别结果 === %@", jsonResult);
        } else if (status == GeekSDKDisernStatusFail) {
            NSLog(@"场景识别结果 ====== %@", jsonResult);
        }
        [self showAlertWithTitle:@"" message:jsonResult];
    }];
    
    // 离开围栏、场景的回调
    [GeekSDKManager sharedInstance].eventResultBlock = ^(NSString * _Nonnull jsonResult) {
        NSLog(@"暴露给QQ场景离开围栏的数据 === %@",jsonResult);
    };
}

//结束场景识别
- (void)endClick {
    
    [[GeekSDKManager sharedInstance] endSceneRecognitionWithCompleted:^(GeekSDKDisernStatus status, NSString * _Nonnull jsonResult) {
        if (status == GeekSDKDisernStatusClose) {
            [self showAlertWithTitle:@"" message:jsonResult];
        }
    }];
}

//释放SDK
- (void)reseleSDK {
    
    [[GeekSDKManager sharedInstance] releseSdkWithCompleted:^(GeekSDKManagerReleseStatus status) {
        if (status == GeekSDKManagerReleseStatusSuccess) {
            [self showAlertWithTitle:@"" message:@"释放SDK成功"];
            [self sendNotification];
        }
    }];
}


//上传日志接口
- (void)upLoadLogClick {
    
    [[GeekSDKManager sharedInstance] uploadLogWithCompleted:^(GeekSDKManagerUploadLogStatus status) {
        if (status == GeekSDKManagerUploadLogStatusSuccess) {
            NSLog(@"上传日志成功 === %ld", status);
            [self showAlertWithTitle:@"" message:@"上传日志成功"];
        }
    }];
}

- (void)sendNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CLEAR_IBEACON_LIST" object:nil];
}

#pragma mark - Alert Message
/// 展示提示信息
/// @param title 提示标题
/// @param message 提示内容
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    if (!message || !message.length) {
        return;
    }

    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alertVc.modalPresentationStyle = 0;
    
    if ([UIApplication sharedApplication].keyWindow.rootViewController) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:^{
            // 弹出后1.5s后隐藏
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertVc dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }
}

@end
