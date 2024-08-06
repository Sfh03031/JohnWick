//
//  Target_Home.swift
//  JohnWick_Example
//
//  Created by sfh on 2024/8/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class Target_Home: NSObject {
    
    @objc func Action_toHome(_ param: [String: Any]) -> UIViewController {
        let vc = HomeVC()
        vc.key = param["key"] as? String ?? ""
        vc.name = param["name"] as? String ?? ""
        
        return vc
    }
}
