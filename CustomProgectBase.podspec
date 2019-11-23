#
#  Be sure to run `pod spec lint CustomProgectBase.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "CustomProgectBase"
  spec.version      = "0.0.1"
  spec.summary      = "工程初始化工具"

  spec.description  = <<-DESC
  1.重定义屏幕尺寸,导航,状态栏,安全区高度等 2.生成固定设备ID 3.重新定义尺寸,字体大小 4.自定义Log 5.支持Runtime
                   DESC

  spec.homepage     = "https://github.com/YXJ1142226297/CustomProgectBase"


  spec.license      = "MIT"


  spec.author             = { "于晓杰" => "1142226297@qq.com" }

  spec.platform     = :ios, "9.0"
  spec.swift_version = '5.0'

  spec.source       = { :git => "https://github.com/YXJ1142226297/CustomProgectBase.git", :tag => "0.0.1" }

  spec.source_files  = "CustomProgectBase/*.swift"

end
