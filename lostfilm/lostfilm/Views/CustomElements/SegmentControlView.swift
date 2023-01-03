//
//  SegmentControlView.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-16.
//

import Foundation

class SegmentControlView: UIView {

    // MARK: Variables
    let contentView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["One", "Two"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(handle), for: .valueChanged)
        return segment
    }()

    // MARK: Inits

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    func setup() {
        contentView.addSubview(segment)
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
