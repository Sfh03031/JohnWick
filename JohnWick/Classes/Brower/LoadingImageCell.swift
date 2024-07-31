//
//  LoadingImageCell.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import JXPhotoBrowser
import Kingfisher
import UIKit

/// 加上进度环的Cell
class LoadingImageCell: JXPhotoBrowserImageCell {
    /// 进度环
    let progressView = JXPhotoBrowserProgressView()

    override func setup() {
        super.setup()
        addSubview(progressView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }

    func reloadData(placeholder: UIImage?, urlString: String?) {
        progressView.progress = 0
        let url = urlString.flatMap { URL(string: $0) }
        imageView.kf.setImage(with: url, placeholder: placeholder, options: nil) { [weak self] received, total in
            if total > 0 {
                self?.progressView.progress = CGFloat(received) / CGFloat(total)
            }
        } completionHandler: { [weak self] result in
            switch result {
            case .success:
                self?.progressView.progress = 1.0
            case .failure:
                self?.progressView.progress = 0
            }
            self?.setNeedsLayout()
        }
    }
}
