//
//  SFExStyle+UITextView.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import RxCocoa
import RxSwift
import SFStyleKit
import UIKit

public extension SFExStyle where Base: UITextView {
    /// 最大字符数, 0为无限
    @discardableResult
    func maxCount(_ count: Int) -> SFExStyle {
        base.sf_maxCount = count
        return self
    }
}

// MARK: 增加属性，最大字符数

public extension UITextView {
    private static let maxCountKey = UnsafeRawPointer(bitPattern: "maxCountKey".hashValue)!
    private static let maxCountBagKey = UnsafeRawPointer(bitPattern: "maxCountBagKey".hashValue)!

    /// 最大字符数
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

    /// 最大字符数
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
