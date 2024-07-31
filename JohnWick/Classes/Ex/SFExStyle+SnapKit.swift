//
//  SFExStyle+SnapKit.swift
//  JohnWick
//
//  Created by sfh on 2024/7/26.
//

import SFStyleKit
import SnapKit

extension ConstraintViewDSL: SFExStyleProtocol {}

public extension SFExStyle where Base == ConstraintViewDSL {
    func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        guard let target = base.target as? UIView,
              target.superview != nil
        else {
            return
        }
        base.makeConstraints(closure)
    }

    func remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        guard let target = base.target as? UIView,
              target.superview != nil
        else {
            return
        }
        base.remakeConstraints(closure)
    }

    func updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        guard let target = base.target as? UIView,
              target.superview != nil
        else {
            return
        }
        base.updateConstraints(closure)
    }
}
