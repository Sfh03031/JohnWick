//
//  SFPickerVC.swift
//  JohnWick
//
//  Created by sfh on 2022/7/23.
//

import SFStyleKit
import UIKit

public extension SFExStyle where Base: SFPickerVC {
    @discardableResult
    func titles(_ titles: [String]) -> SFExStyle {
        base.titles = titles
        return self
    }

    @discardableResult
    func complete(_ complete: @escaping (Int, String) -> Void) -> SFExStyle {
        base.complete = complete
        return self
    }

    @discardableResult
    func show() -> SFExStyle {
        base.show()
        return self
    }
}

public class SFPickerVC: UIViewController {
    fileprivate var complete: ((Int, String) -> Void)?
    fileprivate var titles: [String] = []

    @IBOutlet var contentView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var picker: UIPickerView! {
        didSet {
            picker.delegate = self
            picker.dataSource = self
        }
    }

    public convenience init(_ titles: [String], complete: ((Int, String) -> Void)?) {
        self.init(titles: titles, complete: complete)
    }

    init(titles: [String], complete: ((Int, String) -> Void)?) {
        let path = Bundle(for: Self.self).path(forResource: "JohnWick", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path)
        super.init(nibName: "SFPickerVC", bundle: bundle)

        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        self.titles = titles
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
        contentView.transform = CGAffineTransform(translationX: 0, y: 300)
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        hide()
    }

    @IBAction func confirmAction(_ sender: UIButton) {
        let index = picker.selectedRow(inComponent: 0)
        complete?(index, titles[index])
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

// MARK: UIPickerViewDelegate, UIPickerViewDataSource

extension SFPickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        titles.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        titles[row]
    }
}
