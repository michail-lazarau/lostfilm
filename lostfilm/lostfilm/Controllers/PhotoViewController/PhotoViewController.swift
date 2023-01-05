////
////  PhotoViewController.swift
////  lostfilm
////
////  Created by u.yanouski on 2022-12-28.
////
//
import Foundation
import PhotosUI

final class PhotoViewController: UIViewController, PhotoAttaching {
    var imagePickerController: UIImagePickerController

    // MARK: Variables
    private var profileImage: UIImage?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузите фотографию Вашего профиля:"
        label.textColor = UIColor(named: "color")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var linkTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundColor
        view.textAlignment = .right
        return view
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupView()
    }

    init(imagePickerController: UIImagePickerController) {
        self.imagePickerController = UIImagePickerController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions
    private func initialSetup() {
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        addPhotoButton.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        linkTextView.hyperLink(originalText: Texts.RulesTexts.ruleLinkText, hyperLink: Texts.RulesTexts.hyperLink, urlString: Links.rules)
    }
}

private extension PhotoViewController {

    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(titleLabel)
        view.addSubview(addPhotoButton)
        view.addSubview(linkTextView)
        setupConstraints()
    }

    func setupConstraints() {
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
                          bottom: addPhotoButton.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 50)

        addPhotoButton.setDimensions(width: 150, height: 150)
        addPhotoButton.centerX(inView: view)

        linkTextView.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 30)
        linkTextView.setDimensions(width: view.frame.width, height: 50)
    }

    @objc func handleAddProfilePhoto() {
        showChoosingOptions()
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }

        self.profileImage = profileImage

        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)

        dismiss(animated: true, completion: nil)
    }
}
