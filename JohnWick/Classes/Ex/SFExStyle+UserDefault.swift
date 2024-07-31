//
//  SFExStyle+UserDefault.swift
//  JohnWick
//
//  Created by sfh on 2024/7/25.
//

import Foundation
import SFStyleKit

public extension SFExStyle where Base: UserDefaults {
    /// 保存自定义的对象,需要对象实现解归档
    /// - Parameters:
    ///   - object: 要保存的对象
    ///   - key: key
    @discardableResult
    func setByArchived(_ object: NSCoding & NSObjectProtocol, key: String) -> SFExStyle {
        let encodedObject = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        base.set(encodedObject, forKey: key)
        base.synchronize()
        return self
    }

    /// 根据key获取保存的对象,需要对象实现解归档
    /// - Parameters:
    ///   - type: 对象类型
    ///   - key: key
    /// - Returns: 对象
    func getByUnarchived<T: NSObject>(type: T.Type, forKey key: String) -> T? where T: NSCoding & NSObjectProtocol {
        // 指定解档数据所对应的所有数据类型，都则会有警告
        let res: [AnyClass] = [NSString.self, NSNumber.self, NSArray.self, NSDictionary.self, T.self]
        let decodedObject = base.object(forKey: key) as? Data
        if let decoded = decodedObject {
            let object = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: res, from: decoded)
            return object as? T
        }

        return nil
    }
}
