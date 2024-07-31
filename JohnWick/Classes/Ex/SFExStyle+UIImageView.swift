//
//  SFExStyle+UIImageView.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import SFStyleKit
import UIKit

public extension SFExStyle where Base: UIImageView {
    @discardableResult
    func browseEnable(_ a: Bool) -> SFExStyle {
        base.browseEnable = a
        return self
    }

    @discardableResult
    func show() -> SFExStyle {
        base.browseShow()
        return self
    }
}

public extension UIImageView {
    private static let browseEnableKey = UnsafeRawPointer(bitPattern: "browseEnableKey".hashValue)!
    private static let browseTapKey = UnsafeRawPointer(bitPattern: "browseTapKey".hashValue)!

    var browseEnable: Bool {
        get {
            return objc_getAssociatedObject(self, UIImageView.browseEnableKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, UIImageView.browseEnableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue {
                isUserInteractionEnabled = true
                let tap = browseTap ?? UITapGestureRecognizer(target: self, action: #selector(browseShow))
                addGestureRecognizer(tap)
                browseTap = tap
            } else if let tap = browseTap {
                removeGestureRecognizer(tap)
            }
        }
    }

    private var browseTap: UITapGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, UIImageView.browseTapKey) as? UITapGestureRecognizer
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, UIImageView.browseTapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    @IBInspectable
    var browse: Bool {
        set {
            browseEnable = newValue
        }
        get {
            return browseEnable
        }
    }

    @objc fileprivate func browseShow() {
        if let image = image {
            SFImgBrower.browser([image], transView: { [weak self] _ in
                self
            }).show()
        }
    }
}
