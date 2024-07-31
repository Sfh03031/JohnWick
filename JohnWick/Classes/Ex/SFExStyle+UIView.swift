//
//  SFExStyle+UIView.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import RxCocoa
import RxSwift
import SFStyleKit
import UIKit

public extension SFExStyle where Base: UIView {
    var tap: ControlEvent<UITapGestureRecognizer> {
        base.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        base.addGestureRecognizer(tap)
        return tap.rx.event
    }
}
