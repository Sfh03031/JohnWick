//
//  SFScanVC.swift
//  JohnWick
//
//  Created by sfh on 2023/12/2.
//

/**
 所需权限:
    Privacy - Camera Usage Description
    Privacy - Photo Library Usage Description
 */

import swiftScan
import UIKit

public class SFScanVC: LBXScanViewController {
    /// 识别结果回调
    public var complete: ((LBXScanResult?) -> Void)?
    /// 闪关灯开启状态
    private var isOpenedFlash = false
    
    public init(_ complete: ((LBXScanResult?) -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        self.complete = complete
        scanStyle = style
        isOpenInterestRect = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(closeBtn)
        view.insertSubview(flashBtn, aboveSubview: closeBtn)
        view.insertSubview(albumBtn, aboveSubview: closeBtn)
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        closeBtn.frame = CGRect(x: 10, y: 40, width: 40, height: 40)
        flashBtn.frame = CGRect(x: 40, y: view.bounds.height - 80, width: 40, height: 40)
        albumBtn.frame = CGRect(x: view.bounds.width - 80, y: view.bounds.height - 80, width: 40, height: 40)
    }
    
    override public func drawScanView() {
        super.drawScanView()
        if let qRScanView = qRScanView {
            view.insertSubview(qRScanView, belowSubview: closeBtn)
        }
    }
    
    override public func handleCodeResult(arrayResult: [LBXScanResult]) {
        dismissAction(false)
        complete?(arrayResult.first)
    }
    
    // MARK: lazyload
    
    // 扫描视图样式
    private lazy var style: LBXScanViewStyle = {
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44
        style.photoframeAngleStyle = .Outer
        style.photoframeLineW = 2
        style.photoframeAngleW = 28
        style.photoframeAngleH = 28
        style.isNeedShowRetangle = false
        style.anmiationStyle = .LineMove
        style.colorAngle = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        style.animationImage = SFQRCodeManager.shared.bundledImage(named: "qrcode_Scan_Line")
        return style
    }()

    // 退出按钮
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(SFQRCodeManager.shared.bundledImage(named: "navi_back_white"), for: .normal)
        btn.addTarget(self, action: #selector(dismissAnimatedAction), for: .touchUpInside)
        return btn
    }()

    // 闪光灯按钮
    private lazy var flashBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(SFQRCodeManager.shared.bundledImage(named: "flash_close50"), for: .normal)
        btn.setImage(SFQRCodeManager.shared.bundledImage(named: "flash_open50"), for: .selected)
        btn.addTarget(self, action: #selector(openOrCloseFlash), for: .touchUpInside)
        return btn
    }()

    // 打开相册按钮
    private lazy var albumBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(SFQRCodeManager.shared.bundledImage(named: "album50"), for: .normal)
        btn.addTarget(self, action: #selector(openPhotoAlbum), for: .touchUpInside)
        return btn
    }()
}

extension SFScanVC {
    /// 开关闪光灯
    @objc private func openOrCloseFlash() {
        scanObj?.changeTorch()
        isOpenedFlash = !isOpenedFlash
        flashBtn.isSelected = isOpenedFlash
    }

    /// 退出
    @objc private func dismissAnimatedAction() {
        dismissAction()
    }
    
    private func dismissAction(_ animated: Bool = true) {
        if navigationController?.presentingViewController != nil || presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
