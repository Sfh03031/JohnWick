//
//  SFExStyle+Localized.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import Foundation
import SFStyleKit

// MARK: UILabel内容本地化

public extension SFExStyle where Base: UILabel {
    @discardableResult
    func localizedText(_ text: String?) -> SFExStyle {
        base.localizedText = text
        return self
    }
}

public extension UILabel {
    @IBInspectable var localizedText: String? {
        set {
            guard let newValue = newValue else { return }
            text = NSLocalizedString(newValue, comment: "")
        }
        get {
            return nil
        }
    }
}

// MARK: UIButton文本本地化

public extension SFExStyle where Base: UIButton {
    @discardableResult
    func localizedNormalText(_ text: String?) -> SFExStyle {
        base.localizedNormalText = text
        return self
    }

    @discardableResult
    func localizedHighlightedText(_ text: String?) -> SFExStyle {
        base.localizedHighlightedText = text
        return self
    }

    @discardableResult
    func localizedSelectedText(_ text: String?) -> SFExStyle {
        base.localizedSelectedText = text
        return self
    }

    @discardableResult
    func localizedDisabledText(_ text: String?) -> SFExStyle {
        base.localizedDisabledText = text
        return self
    }

    @discardableResult
    func localizedFocusedText(_ text: String?) -> SFExStyle {
        base.localizedFocusedText = text
        return self
    }
}

public extension UIButton {
    @IBInspectable var localizedNormalText: String? {
        set {
            guard let newValue = newValue else { return }
            setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
        }
        get {
            return nil
        }
    }

    @IBInspectable var localizedHighlightedText: String? {
        set {
            guard let newValue = newValue else { return }
            setTitle(NSLocalizedString(newValue, comment: ""), for: .highlighted)
        }
        get {
            return nil
        }
    }

    @IBInspectable var localizedSelectedText: String? {
        set {
            guard let newValue = newValue else { return }
            setTitle(NSLocalizedString(newValue, comment: ""), for: .selected)
        }
        get {
            return nil
        }
    }

    @IBInspectable var localizedDisabledText: String? {
        set {
            guard let newValue = newValue else { return }
            setTitle(NSLocalizedString(newValue, comment: ""), for: .disabled)
        }
        get {
            return nil
        }
    }

    @IBInspectable var localizedFocusedText: String? {
        set {
            guard let newValue = newValue else { return }
            setTitle(NSLocalizedString(newValue, comment: ""), for: .focused)
        }
        get {
            return nil
        }
    }
}

// MARK: UITextField内容本地化

public extension SFExStyle where Base: UITextField {
    @discardableResult
    func localizedText(_ text: String?) -> SFExStyle {
        base.localizedText = text
        return self
    }

    @discardableResult
    func localizedPlaceholderText(_ text: String?) -> SFExStyle {
        base.localizedPlaceholderText = text
        return self
    }
}

public extension UITextField {
    @IBInspectable var localizedText: String? {
        set {
            guard let newValue = newValue else { return }
            text = NSLocalizedString(newValue, comment: "")
        }
        get {
            return nil
        }
    }

    @IBInspectable var localizedPlaceholderText: String? {
        set {
            guard let newValue = newValue else { return }
            placeholder = NSLocalizedString(newValue, comment: "")
        }
        get {
            return nil
        }
    }
}

// MARK: UITextView内容本地化

public extension SFExStyle where Base: UITextView {
    @discardableResult
    func localizedText(_ text: String?) -> SFExStyle {
        base.localizedText = text
        return self
    }
}

public extension UITextView {
    @IBInspectable var localizedText: String? {
        set {
            guard let newValue = newValue else { return }
            text = NSLocalizedString(newValue, comment: "")
        }
        get {
            return nil
        }
    }
}
