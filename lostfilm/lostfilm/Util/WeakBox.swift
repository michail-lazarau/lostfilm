//
//  WeakBox.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

final class WeakBox<A: AnyObject> {

     weak var value: A?

     init(_ value: A) {
         self.value = value
     }
 }
