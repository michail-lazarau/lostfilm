//
//  LoginVC.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import UIKit


class LoginVC: UIViewController {
    
    //MARK: -Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize  = contentSize
        return scrollView
    }()
    
    private  lazy var  contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor  = .red
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
//    private let logoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.image = Icons.mailIcon
//        return imageView
//    }()
//
    
    private lazy var emailContainerView: UIView = {
        let image = Icons.mailIcon
        let view = Utilities().createInputContainerView(withimage: Icons.mailIcon, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().createInputContainerView(withimage: Icons.passwordIcon, textField: passwordTextField)
        return view
    }()

    private let emailTextField: UITextField = {
        let textField = Utilities().createTextField(withPlaceholder: Texts.email)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = Utilities().createTextField(withPlaceholder: Texts.password)
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Texts.logIn, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        configureStackView()
        
    }

    // MARK: - Selectors
    
    @objc func handleLogin() {
        print("LogIn button clicked")
    }
    
    @objc func handleSingUp() {
        print("SignUp button clicked")
    }

    // MARK: - Hepler Funtions
    
    func configureStackView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
    }
}

//        view.backgroundColor = .black
//
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//

//        let stackView = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.distribution = .fillEqually
//
//        contentView.addSubview(stackView)
//
//

