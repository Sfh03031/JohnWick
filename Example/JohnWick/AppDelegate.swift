//
//  AppDelegate.swift
//  JohnWick
//
//  Created by Sfh03031 on 07/30/2024.
//  Copyright (c) 2024 Sfh03031. All rights reserved.
//

import UIKit
import CTMediator
import JohnWick

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 协议来源：本进程或其它进程，通过bundleID来区分
        if options[.sourceApplication] != nil {
            if url.scheme == JWScheme {// 自定义协议
                let bundleId = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? ""
                if let sourceApp = options[.sourceApplication] as? String, sourceApp == bundleId {
                    // 本进程内的协议跳转
                    toSchemePage(url: url.absoluteString)
                    return true
                } else {
                    // 其它进程通过协议拉起本进程内的页面
                    toSchemePage(url: url.absoluteString)
                    return false
                }
            } else { // 其他协议，支付宝、微信...
                return false
            }
        } else { //浏览器直接过来的
            if url.scheme == JWScheme {
                toSchemePage(url: url.absoluteString)
                return true
            } else { // 其他协议，支付宝、微信...
                return false
            }
        }
    }
    
    /// 协议跳转页面
    /// - Parameter url: 协议字符串
    public func toSchemePage(url: String) {
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
        if let vc = CTMediator.sharedInstance().openUrl(url, moduleName: bundleName, completion: nil) {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            SF.visibleVC?.present(vc, animated: true)
        }
    }
}

