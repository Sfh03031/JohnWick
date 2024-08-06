//
//  ViewController.swift
//  JohnWick
//
//  Created by Sfh03031 on 07/30/2024.
//  Copyright (c) 2024 Sfh03031. All rights reserved.
//

import UIKit
import JohnWick
import CTMediator

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        SF.tools
//        SF.runtime
//        SF.hud
//        SF.taptic
//        SF.imgBrower
//        SF.fileBrower
//        SF.qrcode
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 密码输入框
        self.view.addSubview(codeView)
        codeView.textEntered = { finalText in
            SFLog("textEntered  finalText: \(finalText)")
        }
        
        // 水平线
        self.view.addSubview(hLineView)
        hLineView.snp.makeConstraints { make in
            make.left.equalTo(60)
            make.top.equalTo(SF.TopSafeHeight + 30)
            make.width.equalTo(80)
        }
        
        // 垂直线
        self.view.addSubview(vLineView)
        vLineView.snp.makeConstraints { make in
            make.right.equalTo(-60)
            make.top.equalTo(SF.TopSafeHeight + 30)
            make.height.equalTo(80)
        }

        // 条形码或二维码图片
        imgView.center = self.view.center
        self.view.addSubview(imgView)
        
        self.view.addSubview(tapBtn)
        
        // 数据的归档与解档
        let dic = ["name": 111, "key": 123.0, "age": 18, "temp": ["t": 666, "p": "888"], "list": [
            ["name": "222", "sub": "hhh"],
            ["name": "333", "sub": "hhh"],
        ]] as NSDictionary
        UserDefaults.standard.sf.setByArchived(dic, key: "defkey")
        SF.delay(second: 2) {
            SFLog(UserDefaults.standard.sf.getByUnarchived(type: NSDictionary.self, forKey: "defkey"))
        }
        
        // 开启下拉刷新触觉反馈
        SFMJRefreshTaptic.shared.enable = true
    }
    
    @objc func btnClick(_ sender: UIButton) {
        
//        SFTools.goAppStore(appId: "")
        
        // 文件picker
//        SFFilePickerVC { url, data in
//            SFFileBrowser.init(fileUrl: url).show()
//        }.show()
            
        // 地址picker
//        SFAddressPickerVC.init(.area) { model, model1, model2 in
//            SFLog("\(model?.name)\(model1?.name)\(model2?.name)")
//        }.show()
            
        // 日期picker
//        SFDatePickerVC(.dateAndTime, style: .inline) { date in
//            SFLog(date)
//        }.show()
        
        // 自定义picker
//        SFPickerVC(["aaa", "bbb", "ccc", "DKA"]) { index, value in
//            SFLog("\(index) + \(value)")
//        }.show()
            
        // 标签picker
//        SFTagPickerVC([("aaa", false), ("bbbbbb", false), ("ccccc", false), ("dddeee", true)], maxNum: 1) { list in
//            SFLog(list)
//        }.show()
        
        // 生成条形码
//        self.imgView.image = SFQRCodeManager.shared.makeBarCode(content: "1357924680", size: CGSize(width: 200, height: 100))
        
        // 生成二维码
//        self.imgView.image = SFQRCodeManager.shared.makeQRCode(content: "https://www.baidu.com/",
//                                                               size: CGSize(width: 200, height: 200),
//                                                               codeColor: .systemTeal,
//                                                               bgColor: .orange.withAlphaComponent(0.5),
//                                                               logo: UIImage(systemName: "figure.badminton")?.withTintColor(.red.withAlphaComponent(0.5), renderingMode: .alwaysOriginal),
//                                                               logoSize: CGSize(width: 50, height: 50))
        
        // 扫码
//        let vc = SFScanVC { result in
//            SFLog(result?.strScanned)
//            SFLog(result?.strBarCodeType)
//        }
//        self.present(vc, animated: true, completion: nil)

        // 图片预览
//        let list = [
//            UIImage(systemName: "figure.run")!,
//            UIImage(systemName: "figure.american.football")!,
//            UIImage(systemName: "figure.archery")!,
//            UIImage(systemName: "figure.badminton")!,
//            UIImage(systemName: "figure.basketball")!,
//            UIImage(systemName: "figure.open.water.swim")!
//        ]
//        SFImgBrower.browser(list, transView: { [weak self] index in
//            return index == 0 ? self?.imgView : self?.tapBtn
//        }).show()
        
        // message弹窗
//        SFHUD.makeMessage(title: "提示", desc: "hahhahahahhaahhahahahahhhahahahahhaha", duration: 5.0, position: .top, btnTitle: "哈马斯") {
//            SFHUD.dismissMessage()
//        }
        
        // toast弹窗
//        SFHUD.makeToast("hahhahahahhaahhahahahahhhahahahahhaha", duration: 3.0, position: .center)
        
        // Noti: 更新loading&progress属性配置
//        SFHUD.makeStatus(animationColor: .systemTeal, hudColor: .red, maskColor: .orange, textColor: .brown, textFont: UIFont.systemFont(ofSize: 20.0, weight: .medium))
        
        // loading弹窗
//        SFHUD.makeLoading("loading...", animationType: .horizontalBarScaling, interaction: false)
//        SF.delay(second: 3) {
//            SFHUD.dismissLoading()
//        }
        
        // progress弹窗
//        SFHUD.makeProgress(0.1, title: "下载进度：10%")
//        SF.delay(second: 0.1) {
//            SFHUD.makeProgress(0.2, title: "下载进度：20%")
//            SF.delay(second: 0.1) {
//                SFHUD.makeProgress(0.3, title: "下载进度：30%")
//                SF.delay(second: 0.1) {
//                    SFHUD.makeProgress(0.4, title: "下载进度：40%")
//                    SF.delay(second: 0.1) {
//                        SFHUD.makeProgress(0.5, title: "下载进度：50%")
//                        SF.delay(second: 0.1) {
//                            SFHUD.makeProgress(0.6, title: "下载进度：60%")
//                            SF.delay(second: 0.1) {
//                                SFHUD.makeProgress(0.7, title: "下载进度：70%")
//                                SF.delay(second: 0.1) {
//                                    SFHUD.makeProgress(0.8, title: "下载进度：80%")
//                                    SF.delay(second: 0.1) {
//                                        SFHUD.makeProgress(0.9, title: "下载进度：90%")
//                                        SF.delay(second: 0.1) {
//                                            SFHUD.makeProgress(1.0, title: "下载进度：100%", yep: true)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        // 进程内解耦
//        let param = ["key": "111", "name": "芭芭雅嘎"] as [AnyHashable: Any]
//        guard let vc = CTMediator.sharedInstance().toHome(param) else {
//            SFHUD.makeToast("模块缺失")
//            return
//        }
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true)
        
        // 进程内解耦，带回调
//        let param = ["key": "111", "name": "芭芭雅嘎"] as [AnyHashable: Any]
//        guard let vc = CTMediator.sharedInstance().toMine(param, callBack: { key, name in
//            SFLog("收到回调: key == \(key), name == \(name)")
//        }) else {
//            SFHUD.makeToast("模块缺失")
//            return
//        }
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true)
        
        // 进程内协议跳转
        let path = "babayaga://Home/toHome?key=111&name=芭芭雅嘎"
        SF.tools.openSchemeUrl(path)
        
        // 模拟通过协议唤起App并跳转至目标页面：安装app后把协议粘贴到safari浏览器打开

    }
    
    lazy var codeView: SFCodeInputView = {
        let view = SFCodeInputView()
        view.backgroundColor = .lightGray
        view.frame = CGRect(x: 10, y: SF.StatusBarHeight + 10, width: SF.SCREEN_WIDTH - 20, height: 40)
        view.numberOfSlots = 6
        view.baseWith = 40.0
        view.placeholder = "___"
        view.textFont = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.delegate = self
        return view
    }()
    
    lazy var imgView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        view.browseEnable = true
        return view
    }()
    
    lazy var hLineView: SFLineView = {
        let view = SFLineView()
        view.lineWith = 2.0
        view.lineColor = .systemTeal
        view.horizontal = true
        return view
    }()
    
    lazy var vLineView: SFLineView = {
        let view = SFLineView()
        view.lineWith = 2.0
        view.lineColor = .orange
        view.horizontal = false
        return view
    }()
    
    lazy var tapBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 50, y: SF.SCREEN_HEIGHT - 100, width: SF.SCREEN_WIDTH - 100, height: 44)
        btn.setTitle("点我", for: .normal)
        btn.setTitleColor(.systemTeal, for: .normal)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: SFCodeInputViewDelegate
extension ViewController: SFCodeInputViewDelegate {
    func onTextEntered(_ finalText: String) {
        SFLog("delegate finalText: \(finalText)")
    }
}

