//
//  SFQRCodeManager.swift
//  JohnWick
//
//  Created by sfh on 2024/7/22.
//

import swiftScan
import UIKit

public extension SF {
    static var qrcode: SFQRCodeManager.Type {
        return SFQRCodeManager.self
    }
}

@objcMembers
public class SFQRCodeManager: NSObject {
    /// 单例
    public static let shared = SFQRCodeManager()

    /// 获取bundle内图片
    /// - Parameter name: 图片名称
    /// - Returns: 图片
    public func bundledImage(named name: String) -> UIImage {
        let primaryBundle = Bundle(for: SFQRCodeManager.self)
        if let img = UIImage(named: name, in: .module, compatibleWith: nil) {
            return img
        } else if let img = UIImage(named: name, in: primaryBundle, compatibleWith: nil) {
            return img
        } else if let subBundleUrl = primaryBundle.url(forResource: "JohnWick", withExtension: "bundle"),
                  let subBundle = Bundle(url: subBundleUrl),
                  let img = UIImage(named: name, in: subBundle, compatibleWith: nil)
        {
            return img
        }
        return UIImage()
    }

    /// 获取bundle内颜色
    /// - Parameter name: 颜色名称
    /// - Returns: 颜色
    public func bundledColor(named name: String) -> UIColor? {
        let primaryBundle = Bundle(for: SFQRCodeManager.self)
        if let color = UIColor(named: name, in: .module, compatibleWith: nil) {
            return color
        } else if let color = UIColor(named: name, in: primaryBundle, compatibleWith: nil) {
            return color
        } else if let subBundleUrl = primaryBundle.url(forResource: "JohnWick", withExtension: "bundle"),
                  let subBundle = Bundle(url: subBundleUrl),
                  let color = UIColor(named: name, in: subBundle, compatibleWith: nil)
        {
            return color
        }
        return nil
    }

    /// 创建二维码
    /// - Parameters:
    ///   - codeString: 内容
    ///   - size: 二维码大小
    ///   - codeColor: 二维码颜色, 默认黑色
    ///   - bgColor: 二维码背景颜色, 默认白色
    ///   - logo: 中间logo
    ///   - logoSize: 中间logo大小
    /// - Returns: 创建好的二维码图片
    public func makeQRCode(content: String, size: CGSize, codeColor: UIColor = .black, bgColor: UIColor = .white, logo: UIImage? = nil, logoSize: CGSize = CGSize.zero) -> UIImage? {
        var qrImg = LBXScanWrapper.createCode(codeType: "CIQRCodeGenerator", codeString: content, size: size, qrColor: codeColor, bkColor: bgColor)
        if let logo = logo, let originImg = qrImg {
            qrImg = LBXScanWrapper.addImageLogo(srcImg: originImg, logoImg: logo, logoSize: logoSize)
        }
        return qrImg
    }

    /// 创建条形码
    /// - Parameters:
    ///   - content: 内容(字母和数字)
    ///   - size: 条形码大小
    /// - Returns: 创建好的条形码图片
    public func makeBarCode(content: String, size: CGSize) -> UIImage? {
        LBXScanWrapper.createCode128(codeString: content, size: size, qrColor: .black, bkColor: .white)
    }
}

private extension Bundle {
    static var module: Bundle { return Bundle(for: SFQRCodeManager.self) }
}
