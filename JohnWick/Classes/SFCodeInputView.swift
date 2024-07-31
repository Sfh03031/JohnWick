//
//  SFCodeInputView.swift
//  JohnWick
//
//  Created by sfh on 2023/11/20.
//

import UIKit

public protocol SFCodeInputViewDelegate: AnyObject {
    func onTextEntered(_ finalText: String)
}

@IBDesignable
public final class SFCodeInputView: UIView, UIKeyInput {
    public weak var delegate: SFCodeInputViewDelegate?
    
    private var lock: Bool = false
    private var currentSlot: Int = 1
    
    public var textEntered: ((String) -> Void)?
    public var keyboard: UIKeyboardType = .numbersAndPunctuation
    
    @IBInspectable public var numberOfSlots: Int = 4 {
        didSet {
            clearAndGenerate()
        }
    }
    
    @IBInspectable public var baseWith: CGFloat = 50.0 {
        didSet {
            clearAndGenerate()
        }
    }
    
    @IBInspectable public var placeholder: String = "___" {
        didSet {
            clearAndGenerate()
        }
    }
    
    @IBInspectable public var textFont: UIFont = .boldSystemFont(ofSize: 25) {
        didSet {
            clearAndGenerate()
        }
    }
    
    // MARK: - Properties
    
    public var hasText: Bool {
        return currentSlot > 1
    }
    
    override public var canBecomeFirstResponder: Bool { true }
    
    public var keyboardType: UIKeyboardType {
        get {
            keyboard
        }
        set {
            keyboard = newValue
        }
    }
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        if hasText { return }
        clearAndGenerate()
    }
    
    // MARK: - (UIKeyInput) Insert/Delete text
    
    public func insertText(_ text: String) {
        if currentSlot > numberOfSlots { return }
        if lock { return }
        guard let label = viewWithTag(currentSlot) as? UILabel else { return }
        
        currentSlot += 1
        lock = true
        
        UIView.animate(withDuration: 0.05, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            label.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            label.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveEaseInOut, animations: {
                label.alpha = 1
                label.transform = .identity
                label.text = text
            }) { _ in
                self.lock = false
                self.updateTextStatus()
            }
        }
    }
    
    public func deleteBackward() {
        if currentSlot <= 1 { return }
        currentSlot -= 1
        guard let label = viewWithTag(currentSlot) as? UILabel else { return }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            label.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            label.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                label.alpha = 1
                label.transform = .identity
                label.text = self.placeholder
            }, completion: nil)
        }
    }
    
    // MARK: - Slots generator
    
    public func generateSlots() {
        for index in 1...numberOfSlots {
            currentSlot = index
            addSubview(label)
        }
        currentSlot = 1
    }
    
    private func clearView() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    private func clearAndGenerate() {
        clearView()
        generateSlots()
    }
    
    /// Calculate X position of slot
    private var xPostion: CGFloat {
        return (frame.width - (baseWith * CGFloat(numberOfSlots))) / 2 + CGFloat(currentSlot - 1) * CGFloat(baseWith)
    }
    
    private var frameRect: CGRect {
        CGRect(x: xPostion, y: 0, width: baseWith, height: frame.height)
    }
    
    private var currentText: String {
        var code = ""
        for slot in 1...numberOfSlots {
            guard let value = (viewWithTag(slot) as? UILabel)?.text else { continue }
            code += value
        }
        return code
    }
    
    private var label: UILabel {
        let lbl = UILabel()
        lbl.frame = frameRect
        lbl.text = placeholder
        lbl.font = textFont
        lbl.textAlignment = .center
        lbl.tag = currentSlot
        return lbl
    }
    
    private func updateTextStatus() {
        if currentSlot == numberOfSlots + 1 {
            delegate?.onTextEntered(currentText)
            textEntered?(currentText)
        }
    }
    
    private func updateTextStatus(_ text: String) {
        let textArray = Array(text)
        for slot in 1...numberOfSlots {
            guard let label = viewWithTag(slot) as? UILabel else { continue }
            label.text = String(textArray[slot - 1])
        }
        currentSlot = numberOfSlots + 1
        delegate?.onTextEntered(text)
        textEntered?(text)
    }
    
    /// Getting touch to activate the view and call becomeFirstResponder()
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if touch.view == self {
            becomeFirstResponder()
        }
    }
}
