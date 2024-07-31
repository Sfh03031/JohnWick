//
//  SFWebViewVC.swift
//  JohnWick
//
//  Created by sfh on 2023/11/20.
//

import UIKit
import WebKit

public class SFWebViewVC: UIViewController {
    public var url: URL? {
        didSet {
            webView.requestUrl = url
        }
    }
    
    public init(_ url: URL? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.bounds
        view.addSubview(webView)
        
        if navigationController?.viewControllers.count == 1 {
            if #available(iOS 13.0, *) {
                if navigationController?.viewControllers.count == 1 {
                    let img = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 14.0, weight: .medium)))?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
                    navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(dismissAction(_:)))
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    /// 退出
    @objc public func dismissAction(_ sender: UIBarButtonItem) {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else if navigationController?.presentingViewController != nil {
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - lazyload
    
    lazy var webView: SFWebView = {
        let view = SFWebView()
        view.titleSubject = { [weak self] title in
            self?.title = title
        }
        view.urlChanged = { [weak self] url in
            SFLog("urlChanged: \(String(describing: url?.absoluteString))")
        }
        return view
    }()
}
