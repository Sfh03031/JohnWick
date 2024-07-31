//
//  SFImgBrower.swift
//  JohnWick
//
//  Created by sfh on 2023/11/20.
//

import Haptica
import JXPhotoBrowser
import UIKit

public extension SF {
    static var imgBrower: SFImgBrower.Type {
        SFImgBrower.self
    }
}

public enum SFImgBrower {
    /// 图片预览
    /// - Parameters:
    ///   - images: 图片链接列表
    ///   - index: 次序
    ///   - isSave: 是否长按保存
    ///   - transView: 转场动画的前向视图
    /// - Returns: 图片浏览器
    public static func browser(_ images: [String], index: Int = 0, isSave: Bool = true, transView: ((Int) -> UIView?)? = nil) -> JXPhotoBrowser {
        let browser = JXPhotoBrowser()
        browser.numberOfItems = { images.count }
        browser.cellClassAtIndex = { _ in
            LoadingImageCell.self
        }
        browser.reloadCellAtIndex = { context in
            let browserCell = context.cell as? LoadingImageCell
            browserCell?.reloadData(placeholder: nil, urlString: images[context.index])
            if isSave {
                browserCell?.longPressedAction = { cell, _ in
                    save(cell)
                }
            }
        }
        browser.pageIndex = index
        if let transView = transView {
            browser.transitionAnimator = JXPhotoBrowserZoomAnimator(previousView: transView)
        }
        return browser
    }

    /// 图片预览
    /// - Parameters:
    ///   - images: 图片对象列表
    ///   - index: 次序
    ///   - isSave: 是否长按保存
    ///   - transView: 转场动画的前向视图
    /// - Returns: 图片浏览器
    public static func browser(_ images: [UIImage], index: Int = 0, isSave: Bool = true, transView: ((Int) -> UIView?)? = nil) -> JXPhotoBrowser {
        let browser = JXPhotoBrowser()
        browser.numberOfItems = { images.count }
        browser.reloadCellAtIndex = { context in
            let browserCell = context.cell as? JXPhotoBrowserImageCell
            browserCell?.imageView.image = images[context.index]
            if isSave {
                browserCell?.longPressedAction = { cell, _ in
                    save(cell)
                }
            }
        }
        browser.pageIndex = index
        if let transView = transView {
            browser.transitionAnimator = JXPhotoBrowserZoomAnimator(previousView: transView)
        }
        return browser
    }

    /// 图片保存
    /// - Parameter cell: 图片预览cell
    private static func save(_ cell: JXPhotoBrowserImageCell) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "保存", style: .default, handler: { _ in
            guard let img = cell.imageView.image else { return }
            img.saveToLocal()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        cell.photoBrowser?.present(alert, animated: true, completion: nil)
    }
}
