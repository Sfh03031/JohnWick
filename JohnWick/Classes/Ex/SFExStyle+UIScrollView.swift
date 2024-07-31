//
//  SFExStyle+UIScrollView.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import MJRefresh
import SFStyleKit
import UIKit

public extension SFExStyle where Base: UIScrollView {
    @discardableResult
    func refreshHeader(_ ignoredTop: CGFloat = 0, _ refresh: @escaping () -> Void) -> SFExStyle {
        let header = MJRefreshNormalHeader(refreshingBlock: refresh)
        header.ignoredScrollViewContentInsetTop = ignoredTop
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.textColor = UIColor.lightGray
        base.mj_header = header
        return self
    }

    @discardableResult
    func refreshFooter(_ loadMore: @escaping () -> Void) -> SFExStyle {
        let footer = MJRefreshBackNormalFooter(refreshingBlock: loadMore)
        footer.isAutomaticallyChangeAlpha = true
        footer.arrowView?.image = nil
        footer.stateLabel?.textColor = UIColor.lightGray
        footer.setTitle("- 到底了 -", for: .noMoreData)
        base.mj_footer = footer
        return self
    }

    /// 上拉下拉都有的时候才可以调用
    @discardableResult
    func endRefreshing(_ count: Int = 0, standard: Int = 10) -> SFExStyle {
        base.mj_header?.endRefreshing()
        count < standard
            ? base.mj_footer?.endRefreshingWithNoMoreData()
            : base.mj_footer?.endRefreshing()
        return self
    }
}
