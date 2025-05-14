<div align="center" >
  <img width="85%" src="image/logo.png" />
</div>

# SFStyleKit

[![CI Status](https://img.shields.io/travis/Sfh03031/SFStyleKit.svg?style=flat)](https://travis-ci.org/Sfh03031/SFStyleKit)
[![Version](https://img.shields.io/cocoapods/v/SFStyleKit.svg?style=flat)](https://cocoapods.org/pods/SFStyleKit)
[![License](https://img.shields.io/cocoapods/l/SFStyleKit.svg?style=flat)](https://cocoapods.org/pods/SFStyleKit)
[![Platform](https://img.shields.io/cocoapods/p/SFStyleKit.svg?style=flat)](https://cocoapods.org/pods/SFStyleKit)

## Introduction

SFStyleKit is a swift library that supports chain programming, so you don't need to write property name and equal operator many times anymore.
At present, it supports 22 types of chain programming methods such as UIKit and CALayer, and provides various extensions for UIDevice,
UIApplication, UIView, UIImage, UIImageView, UIButton, UIColor, etc. such as UIDevice's device model, system version, battery, screen
orientation, screen brightness, device volume, jailbreak status, total/available disk size and other properties or methods; UIApplication's
cache path and memory usage; UIView's click events and animations; UIImage's loading of gif data and saving to system albums; UIImageView's
preview and loading of gif images; UIButton's adjustment the relative position of images and text; UIColor's random colors, Chinese colors,
Pantone's annual colors...and so on.

(zh: SFStyleKit是一个支持链式编程写法的swift库，使用它就不需要写很多的属性名和等于号了。目前，它支持UIKit和CALayer共22种类型的链式编程写法，同时为UIDevice、UIApplication、UIView、UIImage、UIImageView、UIButton、UIColor等提供了各式扩展。例如UIDevice的设备型号、系统版本、电池、屏幕方向、屏幕亮度、设备音量、是否越狱、磁盘总/可用大小等属性或方法；UIApplication的缓存路径、内存使用情况；UIView的点击事件、动画；UIImage的加载gif数据、保存到系统相册；UIImageView的预览、加载gif图片；UIButton的调整图片和文字相对位置；UIColor的随机色、中国色、潘通年度色...等等。)




Like this:

```swift
    let SCREENW: CGFloat = UIScreen.main.bounds.width
    let SCREENH: CGFloat = UIScreen.main.bounds.height
    
    lazy var backView: UIView = {
        let view = UIView()
        view.sf.frame(CGRect(x: 10, y: 100, width: SCREENW - 20, height: SCREENH - 200))
            .backgroundColor(.random)
            .makeBorder(color: .brown, with: 1.0)
            .makeCornerRadius(corners: [.topLeft, .bottomRight], radius: 10.0)
            .makeShadow(5, color: .hex_bbcdc5, offset: CGSize(width: 5, height: 10), opacity: 1)
            .showBadgePoint()
            .addTapAction { view in
                view?.sf.hiddenBadgePoint()
            }
            .addTapsAction(tapsRequired: 2) { view in
                UIAlertController().sf.message("点击了两下").show(self).hidden(2)
            }
            .add(subview: alphaLabel)
            .add(subview: broveLabel)
            .add(subview: btn)
        return view
    }()
    
    self.view.sf.backgroundColor(.white).add(subview: backView)
```
you can see the code in the Example Project.(zh: 可以在示例工程查看以上代码。)

SFStyleKit also provides many easy-to-use extensions that can be viewed based on the source code.

(zh: SFStyleKit也提供了许多易用的扩展，这些扩展的详细信息可在源码里查看。)


Like Colors:

```swift
    /// Chinese Colors(zh: 中国色彩)
    
    /// 丁香色
    class var hex_cca4e3: UIColor { sf.hexColor(hex: "#cca4e3") }
    /// 雪青
    class var hex_b0a4e3: UIColor { sf.hexColor(hex: "#b0a4e3") }
    /// 群青
    class var hex_4c8dae: UIColor { sf.hexColor(hex: "#4c8dae") }
    /// 紫棠
    class var hex_56004f: UIColor { sf.hexColor(hex: "#56004f") }

    .....
    
    /// PanTong Year Colors(zh: 潘通年度色)
    
    /// 2024 - 柔和桃
    class var hex_PT_FFBE98: UIColor { sf.hexColor(hex: "#FFBE98") }
    /// 2023 - 非凡洋红
    class var hex_PT_BE3455: UIColor { sf.hexColor(hex: "#BE3455") }
    /// 2022 - 长春花蓝
    class var hex_PT_6667AB: UIColor { sf.hexColor(hex: "#6667AB") }
    /// 2021 - 明亮黄
    class var hex_PT_F5DF4D: UIColor { sf.hexColor(hex: "#F5DF4D") }
    
    ....
    
```

Like get some current device's infomations(zh: 像获取一些当前设备信息):

```swift
    print("idfv: \(UIDevice.current.sf.idfv)")
    print("StringWithUUID: \(UIDevice.current.sf.StringWithUUID)")
    print("batteryLevel: \(UIDevice.current.sf.batteryLevel)")
    print("batteryState: \(UIDevice.current.sf.batteryState)")
    print("cpuCoreNum: \(UIDevice.current.sf.cpuCoreNum)")
    print("cpuType: \(UIDevice.current.sf.cpuType)")
    print("deviceName: \(UIDevice.current.sf.deviceName)")
    print("deviceType: \(UIDevice.current.sf.deviceType)")
    print("deviceVolume: \(UIDevice.current.sf.deviceVolume)")
    print("diskTotalSize: \(UIDevice.current.sf.diskTotalSize)")
    print("diskAvailableSize: \(UIDevice.current.sf.diskAvailableSize)")
    print("ipAddress: \(String(describing: UIDevice.current.sf.ipAddress))")
    print("isJailbreak: \(UIDevice.current.sf.isJailbreak)")
    print("isSimulator: \(UIDevice.current.sf.isSimulator)")
    print("localizedModel: \(UIDevice.current.sf.localizedModel)")
    print("model: \(UIDevice.current.sf.model)")
    print("name: \(UIDevice.current.sf.name)")
    print("pasteBoardValue: \(UIDevice.current.sf.pasteBoardValue)")
    print("screenBrightness: \(UIDevice.current.sf.screenBrightness)")
    print("screenSize: \(UIDevice.current.sf.screenResolution)")
    print("simProvider: \(UIDevice.current.sf.simProvider)")
    print("systemName: \(UIDevice.current.sf.systemName)")
    print("systemVersion: \(UIDevice.current.sf.systemVersion)")
    
    print("memoryUsage: \(UIApplication.shared.sf.memoryUsage)")
    
``` 

## Requirements

* iOS 12.0 or later
* Swift 5.9.2
* Xcode 15.1

## Installation
<!---->
<!--### Carthage-->
<!--```-->
<!--  github "Sfh03031/SFStyleKit"-->
<!--```-->

### CocoaPods
SFStyleKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SFStyleKit'
```
If you want to use the latest features of SFStyleKit use normal external source dependencies.

```ruby
pod 'SFStyleKit', :git => 'https://github.com/Sfh03031/SFStyleKit.git'
```

SFStyleKit has created sub library about core protocal, if you only want to use it, simply add the following line to your Podfile: 

```ruby
pod 'SFStyleKit/Core'
```

also you can use subspecs, simply add the following line to your Podfile:

```swift
pod 'SFStyleKit', :subspecs => ['Core']
```


## Usage

```swift
import UIKit
import SFStyleKit

class ViewController: UIViewController {
    
    let SCREENW: CGFloat = UIScreen.main.bounds.width
    let SCREENH: CGFloat = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.sf.add(subview: backView).backgroundColor(.white)
        
        print("idfv: \(UIDevice.current.sf.idfv)")
        print("StringWithUUID: \(UIDevice.current.sf.StringWithUUID)")
        print("batteryLevel: \(UIDevice.current.sf.batteryLevel)")
        print("batteryState: \(UIDevice.current.sf.batteryState)")
        print("cpuCoreNum: \(UIDevice.current.sf.cpuCoreNum)")
        print("cpuType: \(UIDevice.current.sf.cpuType)")
        print("deviceName: \(UIDevice.current.sf.deviceName)")
        print("deviceType: \(UIDevice.current.sf.deviceType)")
        print("deviceVolume: \(UIDevice.current.sf.deviceVolume)")
        print("diskTotalSize: \(UIDevice.current.sf.diskTotalSize)")
        print("diskAvailableSize: \(UIDevice.current.sf.diskAvailableSize)")
        print("ipAddress: \(String(describing: UIDevice.current.sf.ipAddress))")
        print("isJailbreak: \(UIDevice.current.sf.isJailbreak)")
        print("isSimulator: \(UIDevice.current.sf.isSimulator)")
        print("localizedModel: \(UIDevice.current.sf.localizedModel)")
        print("model: \(UIDevice.current.sf.model)")
        print("name: \(UIDevice.current.sf.name)")
        print("pasteBoardValue: \(UIDevice.current.sf.pasteBoardValue)")
        print("screenBrightness: \(UIDevice.current.sf.screenBrightness)")
        print("screenSize: \(UIDevice.current.sf.screenResolution)")
        print("simProvider: \(UIDevice.current.sf.simProvider)")
        print("systemName: \(UIDevice.current.sf.systemName)")
        print("systemVersion: \(UIDevice.current.sf.systemVersion)")
        
        print("memoryUsage: \(UIApplication.shared.sf.memoryUsage)")
        
        print("13012345678".maskedPhoneNumber())
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.sf.frame(CGRect(x: 10, y: 100, width: SCREENW - 20, height: SCREENH - 200))
            .backgroundColor(.random)
            .makeBorder(color: .brown, with: 1.0)
            .makeCornerRadius(corners: [.topLeft, .bottomRight], radius: 10.0)
            .makeShadow(5, color: .hex_bbcdc5, offset: CGSize(width: 5, height: 10), opacity: 1)
            .showBadgePoint()
            .addTapAction { view in
                view?.sf.hiddenBadgePoint()
            }
            .addTapsAction(tapsRequired: 2) { view in
                UIAlertController().sf.message("点击了两下").show(self).hidden(2)
            }
            .add(subview: alphaLabel)
            .add(subview: broveLabel)
            .add(subview: btn)
        return view
    }()
    
    lazy var alphaLabel: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 15, y: 50, width: SCREENW - 20 - 30, height: 40),
                                 bgColor: .white,
                                 text: "鹊桥二号",
                                 textColor: .red,
                                 aligment: .center,
                                 radius: 5)
        label.sf.addTapAction { [weak self] view in
            guard let self = self else { return }
            UIAlertController().sf.message("点击了 alphaLabel").show(self).hidden(2)
        }
        return label
    }()
    
    lazy var broveLabel: UILabel = {
        let value = "鹊桥二号中继星自3月20日发射升空后，经过中途修正、近月制动、环月轨道机动，于4月2日按计划进入24小时周期的环月大椭圆使命轨道。4月6日，鹊桥二号中继星成功与正在月球背面开展探测任务的嫦娥四号完成对通测试。4月8日-9日，鹊桥二号中继星与嫦娥六号探测器（地面状态）开展对通测试。"
        
        let label = UILabel()
        label.sf
            .frame(CGRect(x: 50, y: 100, width: SCREENW - 20 - 100, height: 60))
            .bgColor(UIColor.hex_PT_FFBE98)
            .text(value)
            .textColor(.white)
            .font(UIFont.systemFont(ofSize: 15, weight: .semibold))
            .alignment(.center)
            .lines(2)
            .makeCornerRadius(corners: [.topRight, .bottomLeft], radius: 20.0)
            .makeCustomizeBorder(color: .red, with: 2, rectSide: [.left, .top, .bottom], topRight: 20, bottomLeft: 20, isSuperClip: true, isDash: false)
            .addTapAction { [weak self] view in
                guard let self = self else { return }
                UIAlertController.alertStyle(.alert).message("点击了 broveLabel\n\(value)").show(self).hidden(2)
            }
        return label
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRect(x: 50, y: 180, width: SCREENW - 20 - 100, height: 60))
            .imagePosition(title: "click me click me click me click me click me", image: UIImage(named: "img_block"), state: .normal, space: 15.0, position: .bottom)
            .backgroundColor(.hex_0c8918)
            .makeRadius(10.0)
            .addTapAction { [weak self] view in
            guard let self = self else { return }
            UIAlertController.alertStyle(.actionSheet).message("按钮被点击了").show(self).hidden(2)
        }
        
        return btn
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
```
### Customized
You can also create your own methods.(zh: 你也可以创建你自己的方法。)

Like this:
```swift
extension UIView: SFExStyleProtocol {}

public extension SFExStyle where Base: UIView {
    @discardableResult 
    func methodA(_ radius: CGFloat) -> SFExStyle {
        base.layer.cornerRadius = radius
        base.layer.masksToBounds = radius > 0
        return self
    }
}
```
## Support

CLLocation
- CLLocationCoordinate2D
- CLPlacemark

Foundation
- Array
- Bundle
- CGFloat
- Date
- Dictionary
- Double
- Float
- Int
- String

QuartzCore
- CALayer

UIKit
- UIAlertController
- UIApplication
- UIButton
- UICollectionView
- UICollectionViewFlowLayout
- UIColor
- UIControl
- UIDevice
- UIImage
- UIImageView
- UILabel
- UINavigationController
- UIScrollView
- UISlider
- UIStackView
- UISwitch
- UITableView
- UITextField
- UITextView
- UIView
- UIViewController

## Change log

2024.10.11, 0.1.7
- update extensions and readme(zh: 更新扩展和readme)

- newly added supported device names(zh: 新增支持的设备名称)


2024.07.25, 0.1.6
- update extensions(zh: 修改一些扩展)

2024.07.11, 0.1.3
- 1.Fix bugs(zh: 修复bug)

- 2.Add new extensions with UICollectionView and UITableView(zh: 为UICollectionView和UITableView扩展新的注册方法)

2024.05.15, 0.1.2
- 1.Add new common color extensions(zh: 增加新的常用色扩展)
    
- 2.Adjust the hierarchical structure of UIView extension and update several comments(zh: 调整UIView扩展的层级结构，更新若干注释)

2024.04.15, 0.1.1
- Initial version(zh: 初始版本)

## Warning
If the system native method has a return value or a property that is read-only, this extension is not suitable for use.

(zh: 如果系统原生方法有返回值或者属性是只读属性，则不适用这种链式写法的扩展。)
 
## Contributing
Please make an issue or pull request if you have any request.

Bug reports, Documentation, or tests, are always welcome as well.

## Author

Sfh03031, sfh894645252@163.com

## License

SFStyleKit is available under the MIT license. See the LICENSE file for more info.
