//
//  SFTagPickerVC.swift
//  FBSnapshotTestCase
//
//  Created by sfh on 2022/7/23.
//

import SFStyleKit
import TagListView
import UIKit

public extension SFExStyle where Base: SFTagPickerVC {
    @discardableResult
    func primeColor(_ color: UIColor?) -> SFExStyle {
        base.primeColor = color ?? .orange
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> SFExStyle {
        base.font = font
        return self
    }
    
    @discardableResult
    func complete(_ complete: @escaping ([(Int, String)]) -> Void) -> SFExStyle {
        base.complete = complete
        return self
    }
    
    @discardableResult
    func titles(_ titles: [String]) -> SFExStyle {
        base.titles = titles.compactMap { ($0, false) }
        return self
    }
    
    @discardableResult
    func titles(_ titles: [(String, Bool)]) -> SFExStyle {
        base.titles = titles
        return self
    }
    
    @discardableResult
    func maxNum(_ num: Int) -> SFExStyle {
        base.maxNum = num
        return self
    }
    
    @discardableResult
    func show() -> SFExStyle {
        base.show()
        return self
    }
}

public class SFTagPickerVC: UIViewController {
    fileprivate var primeColor: UIColor = .systemTeal
    fileprivate var font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    fileprivate var complete: (([(Int, String)]) -> Void)?
    fileprivate var titles: [(String, Bool)] = []
    /// 最多选择多少, 0代表无限
    fileprivate var maxNum = 0
    /// 选择超出maxNum的回调
    var limitCallBack: ((Int) -> Void)?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
    }

    @IBOutlet var tagListView: TagListView! {
        didSet {
            tagListView.delegate = self
        }
    }
    
    public convenience init(_ titles: [String], maxNum: Int = 0, complete: (([(Int, String)]) -> Void)?) {
        self.init(titles: titles.compactMap { ($0, false) }, maxNum: maxNum, complete: complete)
    }
    
    public convenience init(_ selectTitles: [(String, Bool)], maxNum: Int = 0, complete: (([(Int, String)]) -> Void)?) {
        self.init(titles: selectTitles, maxNum: maxNum, complete: complete)
    }
    
    init(titles: [(String, Bool)], maxNum: Int = 0, complete: (([(Int, String)]) -> Void)?) {
        let path = Bundle(for: Self.self).path(forResource: "JohnWick", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path)
        super.init(nibName: "SFTagPickerVC", bundle: bundle)
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        self.titles = titles
        self.maxNum = maxNum
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

    override public func viewDidLoad() {
        super.viewDidLoad()
        contentView.transform = CGAffineTransform(translationX: 0, y: 300)
        setUI()
        for (index, item) in titles.enumerated() {
            let tagView = tagListView.addTag(item.0)
            tagView.isSelected = item.1
            tagView.tag = 200 + index
            tagView.onLongPress = nil
        }
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnim()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        let selTitles = titles.enumerated().compactMap {
            $0.1.1 ? ($0.0, $0.1.0) : nil
        }
        complete?(selTitles)
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
    
    private func setUI() {
        tagListView.textColor = primeColor
        tagListView.borderColor = primeColor
        tagListView.selectedBorderColor = primeColor
        tagListView.tagSelectedBackgroundColor = primeColor
        tagListView.textFont = font
    }
    
    public func show() {
        SF.visibleVC?.present(self, animated: true, completion: nil)
    }
}

extension SFTagPickerVC: TagListViewDelegate {
    public func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if maxNum > 1 && sender.selectedTags().count >= maxNum && !tagView.isSelected {
            limitCallBack?(maxNum)
            return
        }
        tagView.isSelected = !tagView.isSelected
        titles[tagView.tag - 200].1 = tagView.isSelected
        if maxNum == 1 {
            sender.tagViews.forEach { $0.isSelected = ($0 == tagView && tagView.isSelected) }
            for (index, _) in titles.enumerated() {
                titles[index].1 = (tagView.tag - 200 == index && tagView.isSelected)
            }
        }
    }
}
