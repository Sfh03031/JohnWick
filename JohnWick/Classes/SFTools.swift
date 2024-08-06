//
//  SFTools.swift
//  JohnWick
//
//  Created by sfh on 2023/11/20.
//

import Foundation
import UIKit

public extension SF {
    static var tools: SFTools.Type {
        return SFTools.self
    }
}

public enum SFTools {
    /// 跳转应用商城
    /// - Parameters:
    ///   - appId: 应用的id
    ///   - completion: 回调的闭包
    public static func goAppStore(appId: String, completion: ((Bool) -> Void)? = nil) {
        let urlString = "https://itunes.apple.com/cn/app/id" + appId + "?mt=12"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: completion)
            }
        }
    }
    
}

// MARK: 通过deeplink协议打开页面，自定义对协议的处理逻辑

public extension SFTools {
    
    /// 获得请求参数集合
    /// - Parameter query: 参数字符串
    /// - Returns: 参数集合
    static func getQueryParams(query: String) -> [String: Any]? {
        if let query = query.removingPercentEncoding {
            if query.contains("=") {
                var res: [String: Any] = [:]
                if query.contains("&") {
                    let arr = query.components(separatedBy: "&")
                    for item in arr {
                        let key = item.components(separatedBy: "=").first ?? ""
                        var value = item.components(separatedBy: "=").last ?? ""
                        if value.contains("http") {
                            value = value.removingPercentEncoding ?? ""
                        }
                        res.updateValue(value, forKey: key)
                    }
                    return res
                } else {
                    let key = query.components(separatedBy: "=").first ?? ""
                    var value = query.components(separatedBy: "=").last ?? ""
                    if value.contains("http") {
                        value = value.removingPercentEncoding ?? ""
                    }
                    res.updateValue(value, forKey: key)
                    return res
                }
            } else {
                return nil
            }
        }
        return nil
    }

    /// 通过字符串获取控制器类型
    /// - Parameter vcName: 控制器字符串
    /// - Returns: 控制器类
    static func getVCClassFromString(vcName: String) -> UIViewController.Type? {
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        if let ctrlClass = NSClassFromString((bundleName ?? "") + "." + vcName) as? UIViewController.Type {
            return ctrlClass
        } else {
            return nil
        }
    }

    /// 通过deeplink协议打开页面
    /// - Parameter url: 协议链接
    /// - Returns: Bool
    static func openDeepLinkUrl(url: URL) -> Bool {
        // 协议："JohnWick://com.JohnWick.www.TargetViewController?key=24680&name=name&act=push"

        // "com.JohnWick.www.TargetViewController"
        let host = url.host ?? ""
        // "key=24680&name=name&act=push"
        let query = url.query ?? ""
        // 参数
        let param: [String: Any] = getQueryParams(query: query) ?? [:]
        if host.components(separatedBy: ".").last != nil {
            let vcStr = host.components(separatedBy: ".").last!
            let currentVC = SF.visibleVC
            if let vcCls = getVCClassFromString(vcName: vcStr) {
                let vc = vcCls.init()
                if let act = param["act"] as? String, act == "push" {
                    currentVC?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    vc.modalPresentationStyle = .fullScreen
                    currentVC?.present(vc, animated: true)
                }
                return true
            } else {
                SFLog("字符串转换类型失败")
                return false
            }
        } else {
            SFLog("协议格式不正确")
            return false
        }
    }
}

// MARK: 通过scheme协议打开页面

public extension SFTools {
    
    /// 通过协议打开页面
    /// - Parameter path: 协议链接
    static func openSchemeUrl(_ path: String) {
        // 协议参数value有汉字，做转码
        let url = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? path
        if UIApplication.shared.canOpenURL(URL.init(string: url)!) {
            UIApplication.shared.open(URL.init(string: url)!)
        } else {
            SFHUD.makeToast("无法打开协议链接")
        }
    }
}

// MARK: 对象、json字符串互转

public extension SFTools {
    /// 对象转json字符串
    static func toJsonString(obj: [String: Any]) -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: obj),
              let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
        else {
            return ""
        }

        return JSONString
    }

    /// json字符串转对象
    static func toJsonObj(jsonStr: String) -> [String: Any]? {
        let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return [:]
        }

        return json as? [String: Any]
    }
}

// MARK: UserDefaults非空校验

public extension SFTools {
    /// UserDefaults非空校验，若取不到返回空字符串
    /// - Parameter key: 缓存key
    /// - Returns: 字符串
    static func getUserDefValue(_ key: String) -> String {
        if let value = UserDefaults.standard.object(forKey: key) as? String {
            return value
        } else {
            return ""
        }
    }
}
