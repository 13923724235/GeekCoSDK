# GeekSDK

> 此文档描述为GeekSDK-iOS主要集成步骤，如需了解更多详情请留意最新文档更新https://note.youdao.com/s/Dz5W5rZD

## SDK引⼊后前配置
### 需要在Plist⽂件增加各种权限如下图
![image](https://github.com/13923724235/GeekCoSDK/blob/main/Screenshot/jietu_01.png) 

### 需要调整您项⽬的Build Settings ⾥⾯ Other Linker Flags 配置 增加 -ObjC 内容
![image](https://github.com/13923724235/GeekCoSDK/ScreenShot/jietu_02.png) 

### 配置Singning & Capabilities
![image](https://github.com/13923724235/GeekCoSDK/ScreenShot/jietu_03.png) 

### 把framework引⼊项⽬或者用Cocoapods方式集成
- 手动集成，把framework引⼊项⽬
![image](https://github.com/13923724235/GeekCoSDK/ScreenShot/jietu_04.png) 

- Cocoapods集成，Podfile里添加GeekCoSDK，再在终端执行pod install命令等在集成即可
![image](https://github.com/13923724235/GeekCoSDK/ScreenShot/jietu_05.png) 

## SDK使⽤⽅法
### GeekSDKManager是整个SDK的使⽤对象 该类是⼀个单例，所有消息和场景都是该类做操作。
## ********** 具体使⽤⽅法 **********
1.初始化⽅法
```Objective-C
/// 初始化SDK
/// @param completion 返回对应的初始化结果
- (void)initSdkWithCompleted:(GeekSDKManagerInitBlock)completion;
```

2.开启场景识别
```Objective-C
/// 开启场景识别
/// @param completion 识别后的反馈回调
- (void)startSceneRecognitionWithCompleted:(GeekSDKDisernDataBlock)completion;
```

3.结束场景识别
```Objective-C
/// 结束场景识别
/// @param completion 结束回调
- (void)endSceneRecognitionWithCompleted:(GeekSDKDisernDataBlock)completion;
```

4.释放SDK
```Objective-C
/// 释放SDK
/// @param completion 释放回调
- (void)releseSdkWithCompleted:(GeekSDKManagerReleseBlock)completion;
```

5.上传反馈⽇志
```Objective-C
/// 上传⽇志 
/// @param completion 上传回调
- (void)uploadLogWithCompleted:(GeekSDKManagerUpLoadBlock)completion;
```

## ********** Block数据回调 **********

- 离开场景事件结果回调Block
```Objective-C
@property (nonatomic, copy) GeekSDKEventResultBlock eventResultBlock;
```

- IBeacon⽇志打印回调Block
```Objective-C
@property (nonatomic, copy) GeekSDKManagerIBeaconLogBlock iBeaconLogBlock;
```

- 扫描到的IBeacon设备回调Block
```Objective-C
@property (nonatomic, copy) GeekSDKManagerIBeaconBlock sceneIBeaconBlock;
```

- 获取SDK版本号
```Objective-C
 @property (nonatomic, copy, readonly) NSString *sdkVersion;
```

- 是否开启IBeacon调试⽇志
```Objective-C
 @property (nonatomic, assign) BOOL isIBeaconLog;
```

## 注意事项
其他内容或具体使用可查看Demo代码，此⽂档后续回持续更新。


