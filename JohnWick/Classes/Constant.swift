//
//  Constant.swift
//  SFKit
//
//  Created by sfh on 2023/12/19.
//

/// log打印
/// - Parameters:
///   - message: 内容
///   - file: 文件
///   - lineNumber: 行数
public func SFLog<T>(_ message: T, file: String = #file, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName) - \(lineNumber)行]: \(message)")
    #endif
}
