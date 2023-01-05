//
//  PhotoAttaching.swift
//  lostfilm
//
//  Created by u.yanouski on 2023-01-05.
//

import UIKit
import Photos

protocol PhotoAttaching {
    var imagePickerController: UIImagePickerController { get set }

    func showChoosingOptions()
    func takePhoto()
    func choosePhoto()
}

extension PhotoAttaching where Self: UIViewController {

    func showChoosingOptions() {
        UIAlertController.show(on: self, buildClosure: { builder in // разбрать как работает алерт билдер дефолтный
            builder.style = .actionSheet
            builder.actions = [
                .default(title: "photo_attaching_take", handler: {
                    self.takePhoto()
                }),
                .default(title: "photo_attaching_choose", handler: { 
                    self.choosePhoto()
                }),
                .cancel(title: "cancel", handler: nil)
            ]
        })
    }

    func takePhoto() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { isGranted in
            DispatchQueue.main.async {
                if isGranted && UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.imagePickerController.sourceType = .camera
                    self.present(self.imagePickerController, animated: true, completion: nil)
                } else {
                    self.showAccessDeniedAlertController(
                        with: "camera_access_denied_title",
                        message: "camera_access_denied_message"
                    )
                }
            }
        })
    }

    func choosePhoto() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.imagePickerController.sourceType = .photoLibrary
                    self.present(self.imagePickerController, animated: true, completion: nil)
                default:
                    self.showAccessDeniedAlertController(
                        with: "photo_library_access_denied_title",
                        message: "photo_library_access_denied_message"
                    )
                }
            }
        }
    }

    private func showAccessDeniedAlertController(with title: String, message: String) {
        UIAlertController.show(on: self, buildClosure: { builder in
            builder.style = .alert
            builder.title = title
            builder.message = message
            builder.actions = [
                .default(title: "settings", handler: {
                    self.openSettings()
                }),
                .cancel(title: "cancel", handler: nil)
            ]
        })
    }

    private func openSettings() {
        let application = UIApplication.shared
        if let url = URL(string: UIApplication.openSettingsURLString), application.canOpenURL(url) {
            application.open(url)
        }
    }
}

final class AlertBuilder {
    var title: String?
    var message: String?
    var style: UIAlertController.Style = .alert
    var actions: [UIAlertAction] = []
}

extension UIAlertController {

    class func alert(title: String? = nil, message: String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    class func actionSheet(title: String? = nil, message: String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }

    class func show(on viewController: UIViewController, buildClosure: (AlertBuilder) -> Void) {
        let builder = AlertBuilder()
        buildClosure(builder)
        let alertController = UIAlertController(
            title: builder.title,
            message: builder.message,
            preferredStyle: builder.style
        )
        builder.actions.forEach { alertController.addAction($0) }
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension UIAlertAction {

    class func cancel(title: String?, handler: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel, handler: { _ in
            handler?()
        })
    }

    class func destructive(title: String?, handler: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .destructive, handler: { _ in
            handler?()
        })
    }

    class func `default`(title: String?, handler: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: { _ in
            handler?()
        })
    }
}
