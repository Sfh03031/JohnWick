//
//  SFExStyle+String.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import Foundation
import SFStyleKit
import SwiftDate

public extension SFExStyle where Base == String {
    /// 时间, 距今多久
    /// - Returns: 字符串
    func dateBeforeNow() -> String? {
        return base.toDate()?.convertTo(timezone: Zones.asiaShanghai).toRelative(since: DateInRegion(Date(), region: .current))
    }

    /// 时间转换
    /// - Parameter format: 要转换的时间格式
    /// - Returns: 字符串
    func date(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        return base.toDate()?.convertTo(timezone: Zones.asiaShanghai).toFormat(format, locale: Locales.chinese)
    }
}
