//
//  CountryService.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-19.
//

import Foundation

protocol CountryServiceProtocol {
    func  getCountries(_ cities: @escaping ([Country]) -> Void) // функция для вью модели которая отдает вью моедли Массив структур countries
}

final class CountryService: CountryServiceProtocol {

    let countries = [Country(id: "BY", name: "Republic of Belarus", cities: [City(id: "MSK", name: "Minks"), City(id: "MSK1", name: "Minks1"), City(id: "MSK2", name: "Minks2"), City(id: "MSK3", name: "Minks3")]),
                Country(id: "JP", name: "Japan", cities: [City(id: "JP", name: "Tokyo"), City(id: "JP1", name: "Tokyo2"), City(id: "JP2", name: "Tokyo2"), City(id: "JP3", name: "Tokyo3"), City(id: "JP4", name: "Tokyo4")]),
                Country(id: "UZ", name: "Uzbekistan", cities: [City(id: "TSHK", name: "Tashkent"), City(id: "TSHK", name: "Tashkent"), City(id: "TSHK", name: "Tashkent"), City(id: "TSHK", name: "Tashkent")]),
                Country(id: "IS", name: "Israel", cities: [City(id: "ISR", name: "Jerusalem"), City(id: "ISR", name: "Jerusalem"), City(id: "ISR", name: "Jerusalem"), City(id: "ISR", name: "Jerusalem")]),
                Country(id: "UK", name: "Great Britan", cities: [City(id: "LND", name: "London"), City(id: "LND1", name: "London1"), City(id: "LND2", name: "London2"), City(id: "LND3", name: "London3") ])
    ]

    func getCountries(_ cities: @escaping ([Country]) -> Void) {
        cities(countries)
    }
}
