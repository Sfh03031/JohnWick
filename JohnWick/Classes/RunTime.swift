//
//  RunTime.swift
//  SFSparkKit_Example
//
//  Created by sfh on 2023/11/17.
//

import UIKit

public extension SF {
    static var runtime: RunTime.Type {
        return RunTime.self
    }
}

public enum RunTime {
    /// 方法替换
    /// - Parameters:
    ///   - classType: 方法所属类型
    ///   - target: 被替换的方法名称
    ///   - replace: 替换后的方法名称
    public static func exchangeMethod(class classType: AnyClass, target: String, replace: String) {
        exchangeMethod(class: classType, selector: Selector(target), replace: Selector(replace))
    }
    
    /// 方法替换
    /// - Parameters:
    ///   - classType: 方法所属类型
    ///   - selector: 被替换的方法
    ///   - replace: 替换后的方法
    public static func exchangeMethod(class classType: AnyClass, selector: Selector, replace: Selector) {
        guard let primaryMethod = class_getInstanceMethod(classType, selector) else {
            print("被交换方法 获取失败")
            return
        }
        guard let replaceMethod = class_getInstanceMethod(classType, replace) else {
            print("用于交换方法 获取失败")
            return
        }
        let didAddMethod = class_addMethod(classType, selector, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))
        if didAddMethod {
            class_replaceMethod(classType, replace, method_getImplementation(primaryMethod), method_getTypeEncoding(primaryMethod))
        } else {
            method_exchangeImplementations(primaryMethod, replaceMethod)
        }
    }
    
    /// 获取某个类的所有方法
    /// - Parameter classType: 目标类
    /// - Returns: 方法列表
    public static func methods(from classType: AnyClass) -> [Method] {
        var methodNum: UInt32 = 0
        var list = [Method]()
        let methods = class_copyMethodList(classType, &methodNum)
        for i in 0..<numericCast(methodNum) {
            if let method = methods?[i] {
                list.append(method)
                print(String(utf8String: method_getTypeEncoding(method)!) ?? "")
                print(String(utf8String: method_copyReturnType(method)) ?? "")
                print(String(describing: method_getName(method)))
            }
        }
        free(methods)
        return list
    }
    
    /// 获取某个类的所有属性
    /// - Parameter classType: 目标类
    /// - Returns: 属性列表
    public static func properties(from classType: AnyClass) -> [objc_property_t] {
        var propNum: UInt32 = 0
        var list = [objc_property_t]()
        let properties = class_copyPropertyList(classType, &propNum)
        for i in 0..<numericCast(propNum) {
            if let prop = properties?[i] {
                list.append(prop)
                print(String(utf8String: property_getName(prop)) ?? "")
                print(String(utf8String: property_getAttributes(prop)!) ?? "")
            }
        }
        free(properties)
        return list
    }
    
    /// 获取某个类的所有成员变量
    /// - Parameter classType: 目标类
    /// - Returns: 成员变量列表
    public static func ivars(from classType: AnyClass) -> [Ivar] {
        var ivarNum: UInt32 = 0
        var list = [Ivar]()
        let ivars = class_copyIvarList(classType, &ivarNum)
        for i in 0..<numericCast(ivarNum) {
            if let ivar = ivars?[i] {
                list.append(ivar)
            }
        }
        free(ivars)
        return list
    }
}
