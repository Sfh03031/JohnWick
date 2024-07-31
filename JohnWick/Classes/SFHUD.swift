//
//  SFHUD.swift
//  JohnWick
//
//  Created by sfh on 2021/6/20.
//

import ProgressHUD
import SwiftMessages
import Toast_Swift
import UIKit

public extension SF {
    static var hud: SFHUD.Type {
        return SFHUD.self
    }
}

public enum SFHUD {
    // MARK: message
    
    /// Message
    /// - Parameters:
    ///   - title: 标题(字体大, 加粗)
    ///   - desc: 内容
    ///   - duration: 持续时间/秒, 默认2, 0为永久
    ///   - position: 位置, 默认顶部
    ///   - btnTitle: 按钮文字, 默认无按钮, 设置按钮文字后持续时间为永久
    ///   - complete: 按钮点击
    @MainActor public static func makeMessage(title: String? = nil,
                                   desc: String?,
                                   duration: Double = 2,
                                   position: SwiftMessages.PresentationStyle = .top,
                                   btnTitle: String? = nil,
                                   complete: (() -> Void)? = nil)
    {
//        SF.mainThread {
            SwiftMessages.pauseBetweenMessages = 0
            SwiftMessages.hide(animated: true)
            if title == nil || title?.count == 0, desc == nil || desc?.count == 0 { return }
            let haveBtn = !(btnTitle == nil || btnTitle?.count == 0)
            let duration = haveBtn ? 0 : duration
            let messageView = MessageView.viewFromNib(layout: .cardView)
            messageView.configureTheme(.info)
            messageView.configureContent(title: title, body: desc, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: btnTitle) { _ in
                SwiftMessages.hide()
                complete?()
            }
            messageView.button?.isHidden = !haveBtn
            var config = SwiftMessages.defaultConfig
            config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            config.preferredStatusBarStyle = .lightContent
            config.presentationStyle = position
            config.duration = duration == 0 ? .forever : .seconds(seconds: duration)
            SwiftMessages.show(config: config, view: messageView)
//        }
    }
    
    /// 主动让Message消失
    @MainActor public static func dismissMessage() {
//        SF.mainThread {
            SwiftMessages.hide()
//        }
    }
    
    // MARK: Toast
    
    /// Toast
    /// - Parameters:
    ///   - message: 内容
    ///   - duration: 几秒后消失
    ///   - position: 位置，默认 bottom
    public static func makeToast(_ message: String?,
                                 duration: TimeInterval = 3.0,
                                 position: ToastPosition = .bottom)
    {
        guard let msg = message else { return }
        SF.mainThread {
            SF.WINDOW?.makeToast(msg, duration: duration, position: position)
        }
    }
    
    // MARK: loading&progress属性配置
    
    /// 配置loading&progress属性
    /// - Parameters:
    ///   - animationColor: 动画色
    ///   - hudColor: hud背景色
    ///   - maskColor: 遮罩色
    ///   - textColor: 文字色
    ///   - textFont: 文字字号
    public static func makeStatus(animationColor: UIColor = ProgressHUD.colorAnimation,
                                  hudColor: UIColor = ProgressHUD.colorHUD,
                                  maskColor: UIColor = ProgressHUD.colorBackground,
                                  textColor: UIColor = ProgressHUD.colorStatus,
                                  textFont: UIFont = ProgressHUD.fontStatus)
    {
        ProgressHUD.colorAnimation = animationColor
        ProgressHUD.colorHUD = hudColor
        ProgressHUD.colorBackground = maskColor
        ProgressHUD.colorStatus = textColor
        ProgressHUD.fontStatus = textFont
    }
    
    // MARK: loading

    /// 加载中...
    /// - Parameters:
    ///   - title: 文字
    ///   - animationType: 动画类型
    ///   - interaction: 是否可交互，默认不可以
    public static func makeLoading(_ title: String?,
                                   animationType: AnimationType = .circleStrokeSpin,
                                   interaction: Bool = false)
    {
        ProgressHUD.animationType = animationType
        ProgressHUD.animate(title, interaction: interaction)
    }
    
    // MARK: progress
    
    /// 进度提示
    /// - Parameters:
    ///   - progress: 当前进度 0-1
    ///   - title: 文字
    ///   - yep: 完成后显示成功, 默认显示
    ///   - interaction: 是否可交互, 默认否
    public static func makeProgress(_ progress: CGFloat,
                                    title: String? = nil,
                                    yep: Bool = true,
                                    interaction: Bool = false)
    {
        ProgressHUD.progress(title, progress)
        if progress >= 1 {
            SF.delay(second: 0.3) {
                ProgressHUD.succeed(interaction: interaction)
            }
        }
    }
    
    /// Loading消失
    public static func dismissLoading() {
        ProgressHUD.dismiss()
    }
    
    /// Progress消失
    public static func dismissProgress() {
        ProgressHUD.dismiss()
    }
}
