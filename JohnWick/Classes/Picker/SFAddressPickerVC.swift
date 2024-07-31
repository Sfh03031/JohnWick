//
//  SFAddressPickerVC.swift
//  JohnWick
//
//  Created by sfh on 2022/7/23.
//

import SFStyleKit
import UIKit

public extension SFExStyle where Base: SFAddressPickerVC {
    @discardableResult
    func complete(_ complete: @escaping (SFAddressModel?, SFAddressModel?, SFAddressModel?) -> Void) -> SFExStyle {
        base.complete = complete
        return self
    }
    
    @discardableResult
    func type(_ type: SFAddressType) -> SFExStyle {
        base.type = type
        return self
    }
    
    @discardableResult
    func show() -> SFExStyle {
        base.show()
        return self
    }
}

public enum SFAddressType: CaseIterable {
    case province
    case city
    case area
}

public class SFAddressPickerVC: UIViewController {
    fileprivate var complete: ((SFAddressModel?, SFAddressModel?, SFAddressModel?) -> Void)?
    fileprivate var type: SFAddressType = .area
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var picker: UIPickerView! {
        didSet {
            picker.delegate = self
            picker.dataSource = self
        }
    }
    
    private var dataArray: [SFAddressModel] = []
    private var p_index = 0 {
        didSet {
            picker.selectRow(p_index, inComponent: 0, animated: false)
            if type != .province {
                picker.reloadComponent(1)
                c_index = 0
            }
        }
    }

    private var c_index = 0 {
        didSet {
            picker.selectRow(c_index, inComponent: 1, animated: false)
            if type != .city {
                picker.reloadComponent(2)
                a_index = 0
            }
        }
    }

    private var a_index = 0 {
        didSet {
            picker.selectRow(a_index, inComponent: 2, animated: false)
        }
    }
    
    public convenience init(_ type: SFAddressType = .area, complete: ((SFAddressModel?, SFAddressModel?, SFAddressModel?) -> Void)?) {
        self.init(type: type, complete: complete)
    }
    
    init(type: SFAddressType = .area, complete: ((SFAddressModel?, SFAddressModel?, SFAddressModel?) -> Void)?) {
        let path = Bundle(for: Self.self).path(forResource: "JohnWick", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path)
        super.init(nibName: "SFAddressPickerVC", bundle: bundle)
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        self.type = type
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
        loadData()
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        guard dataArray.count > 0 else { return }
        switch type {
        case .province:
            complete?(dataArray[p_index], nil, nil)
        case .city:
            complete?(dataArray[p_index], dataArray[p_index].children[c_index], nil)
        case .area:
            complete?(dataArray[p_index], dataArray[p_index].children[c_index], dataArray[p_index].children[c_index].children[a_index])
        }
        hide()
    }
    
    private func loadData() {
        if let path = Bundle(for: Self.self).path(forResource: "JohnWick", ofType: "bundle"),
           let mbundle = Bundle(path: path),
           let path = mbundle.path(forResource: "SFA", ofType: "bundle"),
           let bundle = Bundle(path: path),
           let plistPath = bundle.path(forResource: "SFAddress", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: plistPath) as? [String: [[String: Any]]],
           let p = dict["children"]
        {
            dataArray = p.compactMap {
                let model = SFAddressModel()
                model.setValuesForKeys($0)
                return model
            }
            picker.reloadAllComponents()
        }
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

extension SFAddressPickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    /// 列数
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return type == .province ? 1 : type == .city ? 2 : 3
    }
    
    /// 每列行数
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return dataArray.count
        case 1:
            return dataArray[p_index].children.count
        default:
            return dataArray[p_index].children[c_index].children.count
        }
    }
    
    /// 每行内容
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return dataArray[row].name
        case 1:
            return dataArray[p_index].children[row].name
        default:
            return dataArray[p_index].children[c_index].children[row].name
        }
    }
    
    /// 选中某行
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            p_index = row
        case 1:
            c_index = row
        default:
            a_index = row
        }
    }
}

// MARK: SFAddressModel

@objcMembers
public class SFAddressModel: NSObject {
    public var code = 0
    public var pinyin: String?
    public var alias: String?
    public var provinceCode = 0
    public var name: String?
    public var firstLetter: String?
    public var cityCode = 0
    public var children: [SFAddressModel] = []
    
    override public func setValue(_ value: Any?, forKey key: String) {
        if key == "children", let value = value as? [[String: Any]] {
            children = value.compactMap {
                let model = SFAddressModel()
                model.setValuesForKeys($0)
                return model
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}
