//
//  Router.swift
//  JohnWick_Example
//
//  Created by sfh on 2024/8/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import CTMediator

public extension CTMediator {

    /// Home
    /// - Parameter param: 参数集合
    /// - Returns: 目标vc
    @objc func toHome(_ param: [AnyHashable: Any]) -> UIViewController? {
        var params = param
        params[kCTMediatorParamsKeySwiftTargetModuleName] = "JohnWick-Example" // 目标模块的CFBundleName
        
        guard let vc = self.performTarget("Home", action: "toHome", params: params, shouldCacheTarget: false) as? UIViewController else { return nil }
        
        return vc
    }
    
    /// Mine
    /// - Parameters:
    ///   - param: 参数集合
    ///   - callBack: 回调
    /// - Returns: 目标vc
    @objc func toMine(_ param: [AnyHashable: Any], callBack: ((String, String) -> Void)? = nil) -> UIViewController? {
        var params = param
        params["call"] = callBack
        params[kCTMediatorParamsKeySwiftTargetModuleName] = "JohnWick-Example" // 目标模块的CFBundleName
        
        guard let vc = self.performTarget("Mine", action: "toMine", params: params, shouldCacheTarget: false) as? UIViewController else { return nil }
        
        return vc
    }
}
