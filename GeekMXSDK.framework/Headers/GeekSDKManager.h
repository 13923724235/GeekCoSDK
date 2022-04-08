/*
 *　　　　■■■■　　　　　　　　　　　　　　　　　■
 *　　■■　　　　■　　　　　　　　　　　　　　　　■
 *　　■　　　　　　　　　　　　　　　　　　　　　　■
 *　■　　　　　　　　　　■■■　　　　■■■　　　■　　　■
 *　■　　　　　　　　　　■　　■　　　■　　■　　■　　■
 *　■　　　　■■■　　■　　　■　　■　　　■　　■　■
 *　■　　　　　　■　　■■■■■　　■■■■■　　■■■
 *　　■　　　　　■　　■　　　　　　■　　　　　　■　■
 *　　■■　　　　■　　■■　　■　　■■　　■　　■　　■
 *　　　　■■■■　　　　■■■　　　　■■■　　　■　　　■
 *
 * Copyright (c) 2022 Shenzhen Geek. All rights reserved.
 */


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GeekSDKManagerInitStatus){
    GeekSDKManagerInitStatusSuccess = 0, //初始化成功
    GeekSDKManagerInitStatusFail = 1, //初始化失败
};

typedef NS_ENUM(NSInteger, GeekSDKDisernStatus){
    GeekSDKDisernStatusSuccess = 0, //场景识别成功
    GeekSDKDisernStatusClose = 1, //场景识别关闭
    GeekSDKDisernStatusFail = 2, //场景识别失败
};

typedef NS_ENUM(NSInteger, GeekSDKManagerReleseStatus){
    GeekSDKManagerReleseStatusSuccess = 0, //释放成功
    GeekSDKManagerReleseStatusFail = 1, //释放失败
};

typedef NS_ENUM(NSInteger, GeekSDKManagerUploadLogStatus){
    GeekSDKManagerUploadLogStatusSuccess = 0, //log日志上传成功
    GeekSDKManagerUploadLogStatusFail = 1, //log日志上传失败
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^GeekSDKManagerInitBlock)(GeekSDKManagerInitStatus status);
typedef void(^GeekSDKDisernDataBlock)(GeekSDKDisernStatus status, NSString *jsonResult);

typedef void(^GeekSDKEventResultBlock)(NSString *jsonResult);
typedef void(^GeekSDKManagerReleseBlock)(GeekSDKManagerReleseStatus status);

typedef void(^GeekSDKManagerIBeaconBlock)(NSDictionary *iBeaconInfo);
typedef void(^GeekSDKManagerIBeaconLogBlock)(NSString *iBeaconLog);
typedef void(^GeekSDKManagerUpLoadBlock)(GeekSDKManagerUploadLogStatus status);

@interface GeekSDKManager : NSObject

/// 离开场景事件上传结果
@property (nonatomic, copy) GeekSDKEventResultBlock eventResultBlock;

/// IBeacon日志打印回调
@property (nonatomic, copy) GeekSDKManagerIBeaconLogBlock iBeaconLogBlock;

/// 扫描到的IBeacon设备回调
@property (nonatomic, copy) GeekSDKManagerIBeaconBlock sceneIBeaconBlock;

/// 获取SDK版本号
@property (nonatomic, copy, readonly) NSString *sdkVersion;

/// 是否开启IBeacon调试日志
@property (nonatomic, assign) BOOL isIBeaconLog;

/// SDK实例
+ (instancetype)sharedInstance;


/// 初始化SDK
/// @param completion 返回对应的初始化结果
- (void)initSdkWithCompleted:(GeekSDKManagerInitBlock)completion;


/// 开启场景识别
/// @param completion 识别后的反馈回调
- (void)startSceneRecognitionWithCompleted:(GeekSDKDisernDataBlock)completion;


/// 结束场景识别
/// @param completion  结束回调
- (void)endSceneRecognitionWithCompleted:(GeekSDKDisernDataBlock)completion;


/// 释放SDK
/// @param completion 释放回调
- (void)releseSdkWithCompleted:(GeekSDKManagerReleseBlock)completion;


/// 上传日志
/// @param completion 上传回调
- (void)uploadLogWithCompleted:(GeekSDKManagerUpLoadBlock)completion;

@end

NS_ASSUME_NONNULL_END
