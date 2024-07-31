//
//  SFExStyle+UIImage.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import Haptica
import SFStyleKit
import UIKit

public extension SFExStyle where Base: UIImage {
    /// 保存图片到相册
    /// - Parameter complete: 成功或失败
    @discardableResult
    func saveToAlbum() -> SFExStyle {
        UIImageWriteToSavedPhotosAlbum(base, base, #selector(base.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
        return self
    }
}

private extension UIImage {
    @objc func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            SFHUD.makeToast("保存失败", duration: 3.0, position: .center)
        } else {
            Haptic.impact(.light).generate()
            SFHUD.makeToast("保存成功", duration: 3.0, position: .center)
        }
    }
}
