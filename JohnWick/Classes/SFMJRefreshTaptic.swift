//
//  SFMJRefreshTaptic.swift
//  JohnWick
//
//  Created by sfh on 2023/11/20.
//

import Haptica
import MJRefresh
import UIKit

public extension SF {
    static var taptic: SFMJRefreshTaptic.Type {
        return SFMJRefreshTaptic.self
    }
}

public class SFMJRefreshTaptic: NSObject {
    // 单例
    public static let shared = SFMJRefreshTaptic()
    // 是否开启下拉反馈
    @objc public var enable: Bool = false {
        didSet {
            enable ? begin() : ()
        }
    }

    private var exchanged: Bool = false
    private func begin() {
        if exchanged { return }
        exchanged = true
        RunTime.exchangeMethod(class: MJRefreshComponent.self,
                               selector: #selector(setter: MJRefreshComponent.state),
                               replace: #selector(MJRefreshComponent.sf_setState(_:)))
    }
}

extension MJRefreshComponent {
    @objc func sf_setState(_ state: MJRefreshState) {
        sf_setState(state)
        if state == .pulling {
            Haptic.impact(.light).generate()
        }
    }
}
