//
//  SFLineView.swift
//  JohnWick
//
//  Created by sfh on 2023/11/20.
//

import UIKit

@IBDesignable
public class SFLineView: UIView {
    @IBInspectable public dynamic var horizontal: Bool = false
    @IBInspectable public dynamic var lineWith: CGFloat = 1.0
    @IBInspectable public dynamic var lineColor: UIColor? = .black {
        didSet {
            backgroundColor = lineColor
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = lineColor
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = lineColor
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = lineColor
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        snp.makeConstraints { make in
            if horizontal {
                make.height.equalTo(lineWith)
            } else {
                make.width.equalTo(lineWith)
            }
        }
    }
}
