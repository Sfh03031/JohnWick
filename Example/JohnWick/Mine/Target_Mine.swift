//
//  Target_Mine.swift
//  JohnWick_Example
//
//  Created by sfh on 2024/8/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class Target_Mine: NSObject {

    @objc func Action_toMine(_ param: [String: Any]) -> UIViewController {
        let vc = MineVC()
        vc.key = param["key"] as? String ?? ""
        vc.name = param["name"] as? String ?? ""
        if let call = param["call"] as? (String, String) -> Void {
            vc.callbackBlock = call
        }
        
        return vc
    }
}
