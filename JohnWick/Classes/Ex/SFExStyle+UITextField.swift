//
//  SFExStyle+UITextField.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import RxCocoa
import RxSwift
import SFStyleKit
import UIKit

public extension SFExStyle where Base: UITextField {
    /// 最大字符数, 0为不限
    @discardableResult
    func maxCount(_ count: Int) -> SFExStyle {
        base.maxCount = count
        return self
    }
    
    /// 小数点后可以输入几位, -1为不限
    @discardableResult
    func pointCount(_ count: Int) -> SFExStyle {
        base.pointCount = count
        return self
    }
}

// MARK: 增加属性，最大字符数

public extension UITextField {
    private static let maxCountKey = UnsafeRawPointer(bitPattern: "maxCountKey".hashValue)!
    private static let maxCountBagKey = UnsafeRawPointer(bitPattern: "maxCountBagKey".hashValue)!
    
    /// 最大字符数, 0为不限
    var sf_maxCount: Int? {
        get {
            return objc_getAssociatedObject(self, Self.maxCountKey) as? Int
        }
        set {
            if let maxCount = newValue {
                objc_setAssociatedObject(self, Self.maxCountKey, maxCount, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                disposeBag = DisposeBag()
                if maxCount > 0 {
                    rx.textInput.text.orEmpty
                        .subscribe(onNext: { [weak self] text in
                            if text.count > maxCount {
                                self?.text = String(text.prefix(maxCount))
                            }
                        }).disposed(by: disposeBag)
                }
            }
        }
    }
    
    private var disposeBag: DisposeBag {
        get {
            var bag = objc_getAssociatedObject(self, Self.maxCountBagKey) as? DisposeBag
            if bag == nil {
                bag = DisposeBag()
                objc_setAssociatedObject(self, Self.maxCountBagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return bag!
        }
        set {
            objc_setAssociatedObject(self, Self.maxCountBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 最大字符数, 0为不限
    @IBInspectable
    var maxCount: Int {
        get {
            return sf_maxCount ?? 0
        }
        set {
            sf_maxCount = newValue
        }
    }
}

// MARK: 增加属性，小数点后可以输入几位

public extension UITextField {
    private static let pointCountKey = UnsafeRawPointer(bitPattern: "pointCountKey".hashValue)!
    private static let pointCountBagKey = UnsafeRawPointer(bitPattern: "pointCountBagKey".hashValue)!
    
    /// 小数点后可以输入几位, -1为不限
    var sf_pointCount: Int? {
        get {
            return objc_getAssociatedObject(self, Self.pointCountKey) as? Int
        }
        set {
            if let pointCount = newValue {
                objc_setAssociatedObject(self, Self.pointCountKey, pointCount, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                pointDisposeBag = DisposeBag()
                if pointCount >= 0 {
                    rx.textInput.text.orEmpty
                        .subscribe(onNext: { [weak self] text in
                            self?.checkPoint(text)
                        }).disposed(by: pointDisposeBag)
                }
            }
        }
    }
    
    private var pointDisposeBag: DisposeBag {
        get {
            var bag = objc_getAssociatedObject(self, Self.pointCountBagKey) as? DisposeBag
            if bag == nil {
                bag = DisposeBag()
                objc_setAssociatedObject(self, Self.pointCountBagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return bag!
        }
        set {
            objc_setAssociatedObject(self, Self.pointCountBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 检查小数点位置
    /// - Parameter input: 输入内容
    private func checkPoint(_ input: String) {
        if input.count == 0 { return }
        if input == "." {
            text = "0."
            return
        }
        let agoIndex = input.count - 1
        let agoText = subString(value: input, start: 0, length: input.count - 1)
        let newValue = subString(value: input, start: input.count - 1, length: 1)
        if agoText?.contains(".") ?? false {
            if newValue == "." {
                text = String(input.prefix(agoIndex))
            } else {
                if let subfix = input.components(separatedBy: ".").last,
                   let pointCount = sf_pointCount,
                   subfix.count > pointCount
                {
                    text = String(input.prefix(agoIndex))
                }
            }
        }
    }
    
    /// 获取指定位置和长度的字符串
    /// - Parameters:
    ///   - value: 初始字符串
    ///   - start: 起始位置
    ///   - length: 长度, 默认到结束
    /// - Returns: 字符串
    private func subString(value: String, start: Int, length: Int = -1) -> String? {
        if value.count < start + length { return nil }
        var len = length
        if len == -1 {
            len = value.count - start
        }
        let st = value.index(value.startIndex, offsetBy: start)
        let en = value.index(st, offsetBy: len)
        let range = st ..< en
        return String(value[range])
    }
    
    /// 小数点后可以输入几位, -1为不限
    @IBInspectable
    var pointCount: Int {
        get {
            return sf_pointCount ?? 0
        }
        set {
            sf_pointCount = newValue
        }
    }
}
