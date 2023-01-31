//
//  DomainCountryModel.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-20.
//

import Foundation

struct Country {
    var id: String
    var name: String
    var cities: [City]
}

struct City {
    var id: String
    var name: String
}
