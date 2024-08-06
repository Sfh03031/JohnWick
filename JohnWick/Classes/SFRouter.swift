//
//  SFRouter.swift
//  JohnWick
//
//  Created by sfh on 2024/8/6.
//

import CTMediator

public extension CTMediator {
    
    /// 接收自定协议，打开对应页面
    /// - Parameters:
    ///   - url: 协议 sample: aaa://targetA/actionB?id=1234
    ///   - name: 模块名称
    ///   - completion: 回调
    /// - Returns: vc
    @objc func openUrl(_ url: String, moduleName name: String, completion: (([AnyHashable: Any]?) -> Void)?) -> UIViewController? {
        var path = ""
        if url.contains(kCTMediatorParamsKeySwiftTargetModuleName) {
            path = url
        } else {
            path = url + "&\(kCTMediatorParamsKeySwiftTargetModuleName)=\(name)"
        }
        guard let vc = self.performAction(with: URL(string: path), completion: completion) as? UIViewController else { return nil }
        
        return vc
    }
}
