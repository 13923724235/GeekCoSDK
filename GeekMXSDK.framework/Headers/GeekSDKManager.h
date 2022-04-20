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
#import <CoreLocation/CoreLocation.h>

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

@class GeekSDKManager, GKIBeaconServiceManager;

NS_ASSUME_NONNULL_BEGIN

typedef void(^GeekSDKManagerInitBlock)(GeekSDKManagerInitStatus status);
typedef void(^GeekSDKDisernDataBlock)(GeekSDKDisernStatus status, NSString *jsonResult);

typedef void(^GeekSDKEventResultBlock)(NSString *jsonResult);
typedef void(^GeekSDKManagerReleseBlock)(GeekSDKManagerReleseStatus status);

typedef void(^GeekSDKManagerIBeaconBlock)(NSDictionary *iBeaconInfo);
typedef void(^GeekSDKManagerIBeaconLogBlock)(NSString *iBeaconLog);
typedef void(^GeekSDKManagerUpLoadBlock)(GeekSDKManagerUploadLogStatus status);

@protocol GKBeaconRegionDelegate <NSObject>

@optional;
/**
 * 需要在随APP启动的指定类中(如：AppDelegate)实现，区域监听自动启动APP，才能回调成功到指定类中事件
 *
 * 在区域监听中，iOS设备进入beacon设备区域触发该方法
 *
 * @param manager Beacon 管理器
 * @param region Beacon 区域
 *
 */
- (void)beaconManager:(GKIBeaconServiceManager *)manager
       didEnterRegion:(CLRegion *)region;


/**
 * 需要在随APP启动的指定类中(如：AppDelegate)实现，区域监听自动启动APP，才能回调成功到指定类中事件
 *
 * 在区域监听中，iOS设备离开beacon设备区域触发该方法
 *
 * @param manager Beacon 管理器
 * @param region Beacon 区域
 *
 */
- (void)beaconManager:(GKIBeaconServiceManager *)manager
        didExitRegion:(CLRegion *)region;


/**
 * 需要在随APP启动的指定类中(如：AppDelegate)实现，区域监听自动启动APP，才能回调成功到指定类中事件
 *
 * 在调用startMonitoringForRegion:方法，当beacon区域状态变化会触发该方法
 *
 * @param manager Beacon 管理器
 * @param state Beacon 区域状态
 * @param region Beacon 区域
 *
 */
- (void)beaconManager:(GKIBeaconServiceManager *)manager
    didDetermineState:(CLRegionState)state
            forRegion:(CLRegion *)region;

@end

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


/// 用于初始化接收后台区域监听回调类，此函数以及handler实体类都必须是与AppDelegate随同启动，否则无法接收到后台beacon推送
/// @param handler 用于接收后台区域监听回调函数的类。传入的handler类用作接收回调（该类务必随程序的启动即初始化，否则无法接收到回调，默认handler为AppDelegate）
- (void)regionHandler:(id<GKBeaconRegionDelegate>)handler;


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
