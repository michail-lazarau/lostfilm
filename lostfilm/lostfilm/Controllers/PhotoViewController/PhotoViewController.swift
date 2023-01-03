////
////  PhotoViewController.swift
////  lostfilm
////
////  Created by u.yanouski on 2022-12-28.
////
//
import Foundation

final class PhotoViewController: UIViewController {
    // MARK: Variables
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузите фотографию Вашего профиля:"
        label.textColor = UIColor(named: "color")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .red
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(Icons.addPhotoButton, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.button
        return button
    }()

    private lazy var linkTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundColor
        view.setDimensions(width: 0, height: 20)
        return view
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: Functions
    private func initialSetup() {
    }
}

private extension PhotoViewController {

    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(titleLabel)
        view.addSubview(contentView)
        view.addSubview(linkTextView)
        setupConstraints()
    }

    func setupConstraints() {
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
                          bottom: contentView.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor,
                          paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        contentView.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
                           bottom: linkTextView.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor,
                           paddingLeft: 50, paddingRight: 50)
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)


        linkTextView.anchor(top: contentView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor,
                            paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
    }

}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
    }
}
