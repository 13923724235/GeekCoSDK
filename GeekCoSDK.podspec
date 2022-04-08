#
#  Be sure to run `pod spec lint GeekMXSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "GeekCoSDK" #SDK名称
  spec.version      = "1.0.0" #版本号
  spec.summary      = "GeekMXSDK for clickwifi developer." #概要
#描述  （描述一定要比概要多一些,不然会有警告!）
  spec.description  = <<-DESC
                   GeekCoSDK for clickwifi developer.
                   DESC

  spec.homepage     = "https://github.com/13923724235/GeekCoSDK" #github/gitee 上的仓库地址


  spec.license      = { :type => "MIT", :file => "LICENSE" }#创建GitHub仓库时使用的license类型
  spec.author             = { "xiaowu" => "735917654@qq.com" }#作者
  spec.platform     = :ios #支持平台
  spec.ios.deployment_target = '9.0' #支持iOS最低版本
  spec.source       = { :git => "https://github.com/13923724235/GeekCoSDK.git", :tag => spec.version.to_s } #源代码地址
 
  spec.ios.vendored_frameworks = 'GeekMXSDK.framework'#SDK相对本文件路径

  spec.pod_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => '' } #支持架构配置

  spec.frameworks = "UIKit", "Foundation","AudioToolbox"#SDK依赖的系统库文件
 
  spec.requires_arc = true #是否是自动内存管理
 
  spec.dependency "YYModel"#依赖的第三方库1
  spec.dependency "AFNetworking"#依赖的第三方库2

end
