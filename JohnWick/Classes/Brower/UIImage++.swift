//
//  UIImage++.swift
//  JohnWick
//
//  Created by sfh on 2024/7/29.
//

import Haptica
import UIKit

public extension UIImage {
    func saveToLocal() {
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(self.saveImage(image:finishedSavingWithError:contextInfo:)), nil)
    }

    @objc func saveImage(image: UIImage, finishedSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            SFHUD.makeToast("保存失败", duration: 3.0, position: .center)
        } else {
            Haptic.impact(.light).generate()
            SFHUD.makeToast("保存成功", duration: 3.0, position: .center)
        }
    }
}
