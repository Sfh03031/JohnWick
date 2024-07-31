//
//  SF.swift
//  JohnWick
//
//  Created by sfh on 2024/7/22.
//

import Foundation

public enum SF {
    /// WINDOW
    public static var WINDOW: UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.delegate?.window {
                return window
            } else {
                let sence = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
                let window = sence?.windows.first(where: { $0.isKeyWindow })
                return window
            }
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    /// SCREEN_BOUNDS
    public static var SCREEN_BOUNDS: CGRect { UIScreen.main.bounds }
    /// SCREEN_SIZE
    public static var SCREEN_SIZE: CGSize { SCREEN_BOUNDS.size }
    /// SCREEN_WIDTH
    public static var SCREEN_WIDTH: CGFloat { SCREEN_BOUNDS.size.width }
    /// SCREEN_HEIGHT
    public static var SCREEN_HEIGHT: CGFloat { SCREEN_BOUNDS.size.height }
    /// SCREEN_SCALE
    public static var SCREEN_SCALE: CGFloat { UIScreen.main.scale }
    /// SCREEN_CENTER
    public static var SCREEN_CENTER: CGPoint { CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2) }

    /// 状态栏高度
    public static var StatusBarHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return WINDOW?.safeAreaInsets.top ?? 20.0
        } else {
            return 20.0
        }
    }

    /// 导航栏高度
    public static var NavBarHeight: CGFloat { 44.0 }
    /// 顶部高度 = 状态栏高度 + 导航栏高度
    public static var TopSafeHeight: CGFloat { StatusBarHeight + NavBarHeight }

    /// 底部安全区高度
    public static var SafeAreaHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return WINDOW?.safeAreaInsets.bottom ?? 0.0
        } else {
            return 0.0
        }
    }

    /// tabbar高度
    public static var TabBarHeight: CGFloat { 49.0 }
    /// 底部高度 = 底部安全区高度 + tabbar高度
    public static var BottomSafeHeight: CGFloat { SafeAreaHeight + TabBarHeight }
}

public extension SF {
    /// 设备
    enum DeviceIdiom {
        // SE
        case iPhone320
        // 12mini、13mini
        case iPhone360
        // 6、6s、7、8、SE2、X、XS、11Pro
        case iPhone375
        // 12、12Pro、13、13Pro、14
        case iPhone390
        // 14Pro、15、15Pro
        case iPhone393
        // 6P、7P、8P、XR、11、XSMax、11ProMax
        case iPhone414
        // 12ProMax、13ProMax、14Plus
        case iPhone428
        // 14ProMax、15Plus、15ProMax
        case iPhone430
        case iPad
        case iMac
        case iTV
        case iCarPlay
        case iVersion
        case iUnspecified

        public static var idiom: DeviceIdiom {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return iPhoneToWidth()
            case .pad:
                return .iPad
            case .mac:
                return .iMac
            case .tv:
                return .iTV
            case .carPlay:
                return .iCarPlay
            case .vision:
                return .iVersion
            case .unspecified:
                return .iUnspecified
            default:
                return iPhoneToWidth()
            }

            func iPhoneToWidth() -> SF.DeviceIdiom {
                if SCREEN_WIDTH <= 320.0 {
                    return .iPhone320
                } else if SCREEN_WIDTH > 320.0 && SCREEN_WIDTH <= 360.0 {
                    return .iPhone360
                } else if SCREEN_WIDTH > 360.0 && SCREEN_WIDTH <= 375.0 {
                    return .iPhone375
                } else if SCREEN_WIDTH > 375.0 && SCREEN_WIDTH <= 390.0 {
                    return .iPhone390
                } else if SCREEN_WIDTH > 390.0 && SCREEN_WIDTH <= 393.0 {
                    return .iPhone393
                } else if SCREEN_WIDTH > 393.0 && SCREEN_WIDTH <= 414.0 {
                    return .iPhone414
                } else if SCREEN_WIDTH > 414.0 && SCREEN_WIDTH <= 428.0 {
                    return .iPhone428
                } else {
                    return .iPhone430
                }
            }
        }
    }
}

public extension SF {
    /// visibleVC
    weak static var visibleVC: UIViewController? {
        weak var vc = WINDOW?.rootViewController
        while true {
            if vc?.isKind(of: UITabBarController.self) ?? false {
                vc = (vc as? UITabBarController)?.selectedViewController
            } else if vc?.isKind(of: UINavigationController.self) ?? false {
                vc = (vc as? UINavigationController)?.visibleViewController
            } else if vc?.presentedViewController != nil {
                vc = vc?.presentedViewController
            } else {
                break
            }
        }
        return vc
    }

    /// topVC
    weak static var topVC: UIViewController? {
        func topVC(_ vc: UIViewController? = nil) -> UIViewController? {
            let vc = vc ?? WINDOW?.rootViewController
            if let nv = vc as? UINavigationController, !nv.viewControllers.isEmpty {
                return topVC(nv.topViewController)
            }
            if let tb = vc as? UITabBarController, let select = tb.selectedViewController {
                return topVC(select)
            }
            if let _ = vc?.presentedViewController, let nvc = visibleVC?.navigationController {
                return topVC(nvc)
            }
            return vc
        }
        let vc = WINDOW?.rootViewController
        return topVC(vc)
    }
}

public extension SF {
    /// 主线程执行
    static func mainThread(_ work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.async(execute: work)
    }

    /// 延迟执行
    static func delay(second: Double, work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second, execute: work)
    }
}
