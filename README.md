<div align="center" >
  <img width="85%" src="image/logo.png" />
</div>
# JohnWick

[![CI Status](https://img.shields.io/travis/Sfh03031/JohnWick.svg?style=flat)](https://travis-ci.org/Sfh03031/JohnWick)
[![Version](https://img.shields.io/cocoapods/v/JohnWick.svg?style=flat)](https://cocoapods.org/pods/JohnWick)
[![License](https://img.shields.io/cocoapods/l/JohnWick.svg?style=flat)](https://cocoapods.org/pods/JohnWick)
[![Platform](https://img.shields.io/cocoapods/p/JohnWick.svg?style=flat)](https://cocoapods.org/pods/JohnWick)

## Introduction

SFKit is a Swift library that provides support for iOS development, including definitions and encapsulation of commonly used methods such as barcode and QR code recognition and generation, picker selectors, prompt pop ups, file and image previewers, web pages with progress, touch feedback, and some extensions.
(zh: SFKit是一个为iOS开发提供支持的swift库，它包含一些常用方法的定义和封装，比如条形码和二维码的识别与生成、picker选择器、提示弹窗、文件图片预览器、带进度网页、触摸反馈和一些扩展等。)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 13.0 or later
* Swift 5.9.2
* Xcode 15.1

## Installation

JohnWick is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JohnWick'
```

If you want to use the latest features of SFKit use normal external source dependencies.

```ruby
pod 'JohnWick', :git => 'https://github.com/Sfh03031/JohnWick.git'
```

SFKit has created sub libraries, if you want to use them, simply add the following line to your Podfile: 

```ruby
pod 'JohnWick/SF'
pod 'JohnWick/Qrcode'
pod 'JohnWick/Picker'
pod 'JohnWick/Brower'
pod 'JohnWick/Hud'
pod 'JohnWick/Ex'
```

also you can use subspecs, simply add the following line to your Podfile:

```swift
pod 'JohnWick', :subspecs => ['SF', 'Qrcode', 'Picker', 'Brower', 'Hud', 'Ex']
```

## Change log

2024.07.26, 0.1.1
- Initial version

    (zh: 初始版本)
    
## Contributing
Please make an issue or pull request if you have any request.

Bug reports, Documentation, or tests, are always welcome as well.

## Author

Sfh03031, sfh894645252@163.com

## License

JohnWick is available under the MIT license. See the LICENSE file for more info.
