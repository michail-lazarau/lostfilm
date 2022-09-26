//
//  Extentions.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func equalWidth(width: NSLayoutDimension? = nil ) {
        if let width = width {
            widthAnchor.constraint(equalTo: width).isActive = true
            //widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}


//
//func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
//        translatesAutoresizingMaskIntoConstraints = false
//        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        if let topAnchor = topAnchor {
//            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
//        }
//    }
//
//    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
//
//        if let leftAnchor = leftAnchor, let padding = paddingLeft {
//            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
//        }
//    }
