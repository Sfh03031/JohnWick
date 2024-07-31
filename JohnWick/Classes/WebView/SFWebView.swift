//
//  SFWebView.swift
//  JohnWick
//
//  Created by sfh on 2023/11/20.
//

import UIKit
import WebKit

public class SFWebView: WKWebView {
    public var titleSubject: ((String?) -> Void)?
    public var urlChanged: ((URL?) -> Void)?
    
    // @IBDesignable 实时渲染，修饰的类必须是UIView或者NSView的子类
    // @IBInspectable 动态属性，在xcode属性面板中可视化修改属性值。
    // dynamic 告诉编译器属性的setter与getter方法由用户自己实现，不自动生成。
    @IBInspectable public dynamic var progressColor: UIColor? = UIColor.blue {
        didSet {
            progress.tintColor = progressColor
        }
    }
    
    @IBInspectable public dynamic var progressHeight: CGFloat = 1
    
    public var requestUrl: URL? {
        didSet {
            guard let url = requestUrl else { return }
            load(URLRequest(url: url))
        }
    }
    
    private lazy var progress: UIProgressView = {
        let view = UIProgressView()
        view.tintColor = progressColor
        view.trackTintColor = .clear
        view.setProgress(0.1, animated: true)
        view.alpha = 0
        return view
    }()
    
    public convenience init(_ url: URL?) {
        self.init()
        requestUrl = url
        setup()
    }
    
    public init() {
        let config = WKWebViewConfiguration()
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content','width=device-width,initial-scale=1.0,user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].setAttribute('width', '100%');imgs[i].style.height='auto';}"
        let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        config.userContentController = wkUController
        super.init(frame: CGRect.zero, configuration: config)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        // xib初始化没有设置configuration
        setup()
    }
    
    func setup() {
        progress.frame = CGRect(x: 0, y: safeAreaInsets.top, width: frame.width, height: progressHeight)
        addSubview(progress)
        addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        addObserver(self, forKeyPath: "title", options: .new, context: nil)
        addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        guard let url = requestUrl else { return }
        load(URLRequest(url: url))
    }
    
    deinit {
        removeObserver(self, forKeyPath: "estimatedProgress")
        removeObserver(self, forKeyPath: "title")
        removeObserver(self, forKeyPath: "URL")
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress", let object = object as? WKWebView {
            progress.alpha = 1
            progress.setProgress(Float(estimatedProgress), animated: true)
            if estimatedProgress >= 1.0 {
                urlChanged?(object.url)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: { [weak self] in
                    self?.progress.alpha = 0
                }) { [weak self] _ in
                    self?.progress.setProgress(0, animated: true)
                }
            }
        } else if keyPath == "title", let _ = object as? WKWebView {
            titleSubject?(title ?? "")
        } else if keyPath == "URL", let object = object as? WKWebView {
            urlChanged?(object.url)
        }
    }
}
