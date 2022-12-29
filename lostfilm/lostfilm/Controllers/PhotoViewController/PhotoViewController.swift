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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

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
        return imageView
    }()

    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(Icons.addPhotoButton, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.button
        button.setDimensions(width: 150, height: 150)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
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
    }

    // MARK: Functions
    private func initialSetup() {

    }
}

private extension PhotoViewController {

    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(addPhotoButton)
//        contentView.addSubview(linkTextView)
        view.addSubview(addPhotoButton)
        setupConstraints()
    }

    func setupConstraints() {
//        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                          left: view.safeAreaLayoutGuide.leftAnchor,
//                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
//                          right: view.safeAreaLayoutGuide.rightAnchor)
//
//        contentView.anchor(top: scrollView.safeAreaLayoutGuide.topAnchor,
//                           left: scrollView.safeAreaLayoutGuide.leftAnchor,
//                           bottom: scrollView.safeAreaLayoutGuide.bottomAnchor,
//                           right: scrollView.safeAreaLayoutGuide.rightAnchor)
//
//        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0)
//        contentViewHeightConstraint.priority = .defaultLow
//
//        NSLayoutConstraint.activate([contentViewHeightConstraint])

//        titleLabel.anchor(top: contentView.topAnchor,
//                          left: contentView.leftAnchor,
//                          bottom: addPhotoButton.topAnchor,
//                          right: contentView.rightAnchor,
//                          paddingTop: 50, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)

//        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                              left: view.safeAreaLayoutGuide.leftAnchor,
//                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
//                              right: view.safeAreaLayoutGuide.rightAnchor)
//
    }

        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        addPhotoButton.setDimensions(width: 150, height: 150)

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

    func setupConstraints() {}
}

//    let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0)
//    contentViewHeightConstraint.priority = .defaultLow
//
//    scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                      left: view.safeAreaLayoutGuide.leftAnchor,
//                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
//                      right: view.safeAreaLayoutGuide.rightAnchor)
//
//    contentView.anchor(top: scrollView.contentLayoutGuide.topAnchor,
//                       left: scrollView.contentLayoutGuide.leftAnchor,
//                       bottom: scrollView.contentLayoutGuide.bottomAnchor,
//                       right: scrollView.contentLayoutGuide.rightAnchor)
//
//    NSLayoutConstraint.activate([
//        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0.0),
//
//        stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Paddings.top),
//        stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Paddings.bottom),
//        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Paddings.left),
//        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Paddings.right),
//        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0),
//
//        contentViewHeightConstraint])



