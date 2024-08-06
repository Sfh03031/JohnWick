<div align="center" >
  <img width="85%" src="image/logo.png" />
</div>
# JohnWick

[![CI Status](https://img.shields.io/travis/Sfh03031/JohnWick.svg?style=flat)](https://travis-ci.org/Sfh03031/JohnWick)
[![Version](https://img.shields.io/cocoapods/v/JohnWick.svg?style=flat)](https://cocoapods.org/pods/JohnWick)
[![License](https://img.shields.io/cocoapods/l/JohnWick.svg?style=flat)](https://cocoapods.org/pods/JohnWick)
[![Platform](https://img.shields.io/cocoapods/p/JohnWick.svg?style=flat)](https://cocoapods.org/pods/JohnWick)

## Introduction

  JohnWick is a Swift library that provides support for iOS development, including definitions and encapsulation of commonly used methods such as barcode and QR code recognition and generation, picker selectors, prompt pop ups, file and image previewers, web pages with progress, touch feedback, and some extensions.

(zh: JohnWick是一个为iOS开发提供支持的swift库，它包含一些常用方法的定义和封装，比如条形码和二维码的识别与生成、picker选择器、提示弹窗、文件图片预览器、带进度网页、触摸反馈和一些扩展等。)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
    @objc func btnClick(_ sender: UIButton) {
        
//        SFTools.goAppStore(appId: "")
        
        // 文件picker
//        SFFilePickerVC { url, data in
//            SFFileBrowser.init(fileUrl: url).show()
//        }.show()
            
        // 地址picker
//        SFAddressPickerVC.init(.area) { model, model1, model2 in
//            SFLog("\(model?.name)\(model1?.name)\(model2?.name)")
//        }.show()
            
        // 日期picker
//        SFDatePickerVC(.dateAndTime, style: .inline) { date in
//            SFLog(date)
//        }.show()
        
        // 自定义picker
//        SFPickerVC(["aaa", "bbb", "ccc", "DKA"]) { index, value in
//            SFLog("\(index) + \(value)")
//        }.show()
            
        // 标签picker
//        SFTagPickerVC([("aaa", false), ("bbbbbb", false), ("ccccc", false), ("dddeee", true)], maxNum: 1) { list in
//            SFLog(list)
//        }.show()
        
        // 生成条形码
//        self.imgView.image = SFQRCodeManager.shared.makeBarCode(content: "1357924680", size: CGSize(width: 200, height: 100))
        
        // 生成二维码
//        self.imgView.image = SFQRCodeManager.shared.makeQRCode(content: "https://www.baidu.com/",
//                                                               size: CGSize(width: 200, height: 200),
//                                                               codeColor: .systemTeal,
//                                                               bgColor: .orange.withAlphaComponent(0.5),
//                                                               logo: UIImage(systemName: "figure.badminton")?.withTintColor(.red.withAlphaComponent(0.5), renderingMode: .alwaysOriginal),
//                                                               logoSize: CGSize(width: 50, height: 50))
        
        // 扫码
//        let vc = SFScanVC { result in
//            SFLog(result?.strScanned)
//            SFLog(result?.strBarCodeType)
//        }
//        self.present(vc, animated: true, completion: nil)

        // 图片预览
//        let list = [
//            UIImage(systemName: "figure.run")!,
//            UIImage(systemName: "figure.american.football")!,
//            UIImage(systemName: "figure.archery")!,
//            UIImage(systemName: "figure.badminton")!,
//            UIImage(systemName: "figure.basketball")!,
//            UIImage(systemName: "figure.open.water.swim")!
//        ]
//        SFImgBrower.browser(list, transView: { [weak self] index in
//            return index == 0 ? self?.imgView : self?.tapBtn
//        }).show()
        
        ...

    }
```

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

If you want to use the latest features of JohnWick use normal external source dependencies.

```ruby
pod 'JohnWick', :git => 'https://github.com/Sfh03031/JohnWick.git'
```
<!---->
<!--JohnWick has created sub libraries, if you want to use them, simply add the following line to your Podfile: -->
<!---->
<!--```ruby-->
<!--pod 'JohnWick/SF'-->
<!--pod 'JohnWick/Qrcode'-->
<!--pod 'JohnWick/Picker'-->
<!--pod 'JohnWick/Brower'-->
<!--pod 'JohnWick/Hud'-->
<!--pod 'JohnWick/Ex'-->
<!--```-->
<!---->
<!--also you can use subspecs, simply add the following line to your Podfile:-->
<!---->
<!--```swift-->
<!--pod 'JohnWick', :subspecs => ['SF', 'Qrcode', 'Picker', 'Brower', 'Hud', 'Ex']-->
<!--```-->

## Change log

2024.08.06, 0.1.1
- Add decoupling modules and examples.(zh: 增加解耦模块与示例。)

2024.07.26, 0.1.0
- Initial version.(zh: 初始版本。)
    
## Contributing
Please make an issue or pull request if you have any request.

Bug reports, Documentation, or tests, are always welcome as well.

## Author

Sfh03031, sfh894645252@163.com

## License

JohnWick is available under the MIT license. See the LICENSE file for more info.
