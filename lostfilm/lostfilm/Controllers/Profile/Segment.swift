//
//  Segment.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-16.
//

import Foundation

class Segment: UIViewController {

    lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["One", "Two"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(handle), for: .valueChanged)
        return segment
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segment)
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            segment.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10),
            segment.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            segment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segment.heightAnchor.constraint(greaterThanOrEqualToConstant: 35)
        ])
    }

    @objc func handle(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("0")
        case 1:
            print("1")
        default:
            print("-1")
        }
    }
}
