//
//  testVC.swift
//  lostfilm
//
//  Created by u.yanouski on 21/09/2022.
//

import Foundation
import UIKit

class testVC: UIViewController {
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Texts.logIn, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
    }
}
