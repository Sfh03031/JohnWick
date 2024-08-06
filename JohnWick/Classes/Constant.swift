//
//  Constant.swift
//  JohnWick
//
//  Created by sfh on 2023/12/19.
//

/// 自定协议的协议头 【TARGETS -> Info -> URL Types】
public let JWScheme = "babayaga"

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
