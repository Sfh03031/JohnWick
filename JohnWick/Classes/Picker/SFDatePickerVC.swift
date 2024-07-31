//
//  SFDatePickerVC.swift
//  JohnWick
//
//  Created by sfh on 2022/7/23.
//

import SFStyleKit
import UIKit

@available(iOS 13.4, *)
public extension SFExStyle where Base: SFDatePickerVC {
    @discardableResult
    func mode(_ mode: UIDatePicker.Mode) -> SFExStyle {
        base.mode = mode
        return self
    }
    
    @discardableResult
    func style(_ style: UIDatePickerStyle) -> SFExStyle {
        base.style = style
        return self
    }
    
    @discardableResult
    func date(_ date: Date?) -> SFExStyle {
        base.initDate = date ?? Date()
        return self
    }
    
    @discardableResult
    func minDate(_ date: Date?) -> SFExStyle {
        base.minDate = date
        return self
    }
    
    @discardableResult
    func maxDate(_ date: Date?) -> SFExStyle {
        base.maxDate = date
        return self
    }
    
    @discardableResult
    func complete(_ complete: @escaping (Date) -> Void) -> SFExStyle {
        base.complete = complete
        return self
    }
    
    @discardableResult
    func show() -> SFExStyle {
        base.show()
        return self
    }
}

@available(iOS 13.4, *)
public class SFDatePickerVC: UIViewController {
    fileprivate var mode: UIDatePicker.Mode = .date
    fileprivate var style: UIDatePickerStyle?
    fileprivate var initDate = Date()
    fileprivate var minDate: Date?
    fileprivate var maxDate: Date?
    fileprivate var complete: ((Date) -> Void)?

    @IBOutlet var contentView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!

    public convenience init(_ mode: UIDatePicker.Mode, style: UIDatePickerStyle? = nil, initDate: Date? = nil, minDate: Date? = nil, maxDate: Date? = nil, complete: ((Date) -> Void)?) {
        self.init(mode: mode, style: style, initDate: initDate, minDate: minDate, maxDate: maxDate, complete: complete)
    }
    
    init(mode: UIDatePicker.Mode, style: UIDatePickerStyle? = nil, initDate: Date? = nil, minDate: Date? = nil, maxDate: Date? = nil, complete: ((Date) -> Void)?) {
        let path = Bundle(for: Self.self).path(forResource: "JohnWick", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path)
        super.init(nibName: "SFDatePickerVC", bundle: bundle)
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        self.mode = mode
        self.style = style
        self.initDate = initDate ?? Date()
        self.minDate = minDate
        self.maxDate = maxDate
        self.complete = complete
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if touches.contains(where: { $0.view == view }) {
            hide()
        }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnim()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        contentView.transform = CGAffineTransform(translationX: 0, y: 500)
        datePicker.datePickerMode = mode
        datePicker.preferredDatePickerStyle = style ?? .wheels
        datePicker.date = initDate
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        complete?(datePicker.date)
        hide()
    }
    
    private func showAnim() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc private func hide() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.contentView.transform = CGAffineTransform(translationX: 0, y: 500)
            self?.dismiss(animated: true)
        }
    }
    
    public func show() {
        SF.visibleVC?.present(self, animated: true, completion: nil)
    }
}
