//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Vladislav on 30.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named:"mail")
        return imageView
    }()
    
   
    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .blue
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
    }


}
