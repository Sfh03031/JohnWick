//
//  MineVC.swift
//  JohnWick_Example
//
//  Created by sfh on 2024/8/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class MineVC: UIViewController {
    
    var key: String?
    var name: String?
    var callbackBlock: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.infoLabel.center = self.view.center
        self.view.addSubview(self.infoLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.infoLabel.text = "Mine: \n key = \(key ?? ""), name = \(name ?? "")"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.callbackBlock?(key ?? "", name ?? "")
        self.dismiss(animated: true)
    }
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemTeal
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

}
