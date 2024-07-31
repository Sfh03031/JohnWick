#
# Be sure to run `pod lib lint JohnWick.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JohnWick'
  s.version          = '0.1.0'
  s.summary          = 'A library designed to support iOS development by swift.(zh: 一个为iOS开发提供支持的swift库。)'
  s.description      = <<-DESC
  JohnWick is a Swift library that provides support for iOS development, including definitions and encapsulation of commonly used methods such as barcode and QR code recognition and generation, picker selectors, prompt pop ups, file and image previewers, web pages with progress, touch feedback, and some extensions.
  
  (zh: JohnWick是一个为iOS开发提供支持的swift库，它包含一些常用方法的定义和封装，比如条形码和二维码的识别与生成、picker选择器、提示弹窗、文件图片预览器、带进度网页、触摸反馈和一些扩展等。)
                       DESC
  s.homepage         = 'https://github.com/Sfh03031/JohnWick'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sfh03031' => 'sfh894645252@163.com' }
  s.source           = { :git => 'https://github.com/Sfh03031/JohnWick.git', :tag => s.version.to_s }
  s.requires_arc     = true
  s.swift_versions   = '5.0'
  s.platform         = :ios, '13.0'
  s.static_framework = true
    
  s.source_files = 'JohnWick/Classes/**/*'
  s.resource_bundles = {
    'JohnWick' => ['JohnWick/Assets/Picker/*', 'JohnWick/Assets/Qrcode/*.xcassets']
  }
  
  s.dependency 'SFStyleKit/Core'
  s.dependency 'MJRefresh'
  s.dependency 'Haptica'
  s.dependency 'swiftScan'
  s.dependency 'TagListView'
  s.dependency 'JXPhotoBrowser'
  s.dependency 'Kingfisher'
  s.dependency 'SwiftMessages'
  s.dependency 'ProgressHUD', '~> 14.1.1'
  s.dependency 'Toast-Swift'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'SwiftDate'
  s.dependency 'SnapKit'
  
end
