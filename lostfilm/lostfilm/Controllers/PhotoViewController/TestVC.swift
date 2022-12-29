//
//  TestVC.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-28.
//

import Foundation

class TestVC: UIViewController {

    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?


    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()

    private let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing Up", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius  = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleSingUpButton), for: .touchUpInside)
        return button
    }()


    private let alreadyHaveAccountButton: UIButton  = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate  = self
        imagePicker.allowsEditing = true

        configureUI()

    }


    // MARK: - Selectors

    @objc func handleShowLogin() {
        self.dismiss(animated: false, completion: nil)
        print("33")
    }

    @objc func handleAddProfilePhoto() {
        print("handleAddProfilePhoto")
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func handleSingUpButton() {
        print("handleSingUpButton CLICK")
}



    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .blue

        let stack = UIStackView(arrangedSubviews: [
singUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually

        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 150, height: 150)

        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)

        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 40, paddingRight: 40)
    }
}



// MARK: - Extention

//extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func showImagePickerController() {}
//}



extension TestVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }


        self.profileImage = profileImage

        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3

        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)


        dismiss(animated: true, completion: nil)
    }
}
