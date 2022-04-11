//
//  GKSceneIBeacon.h
//  GeekSDKDemo
//
//  Created by Jett on 2022/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKSceneIBeacon : NSObject

/// 当前已经扫描到的设备的UUID
@property (nonatomic, copy) NSString *uuid;

/// major
@property (nonatomic, copy) NSNumber *major;

/// minor
@property (nonatomic, copy) NSNumber *minor;

/// proximity：未知（unknown）、约10厘米（immediate）、1米以内（near）、10米以外（far）
@property (nonatomic, copy) NSString *proximity;

/// accuracy
@property (nonatomic, assign) double accuracy;

/// 信号等级/强弱
@property (nonatomic, assign) NSInteger rssi;


@end

NS_ASSUME_NONNULL_END
