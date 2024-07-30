//
//  SFExStyle.swift
//  SFStyleKit_Example
//
//  Created by sfh on 2024/4/3.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

public protocol SFExStyleProtocol {
    associatedtype CompatibleType
    var sf: CompatibleType { get }
    static var sf: CompatibleType.Type { get }
}

public final class SFExStyle<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public var build: Base {
        return base
    }
}

public extension SFExStyleProtocol {
    var sf: SFExStyle<Self> {
        return SFExStyle(self)
    }
    
    static var sf: SFExStyle<Self>.Type {
        return SFExStyle.self
    }
}

extension NSObject: SFExStyleProtocol {}
extension String: SFExStyleProtocol {}
extension Int: SFExStyleProtocol {}
extension Double: SFExStyleProtocol {}
extension Float: SFExStyleProtocol {}
extension CGFloat: SFExStyleProtocol {}
extension Date: SFExStyleProtocol {}
extension Dictionary: SFExStyleProtocol {}
extension Array: SFExStyleProtocol {}
