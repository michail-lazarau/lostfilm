//
//  ProfileViewModel.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-15.
//

import Foundation

protocol ProfileViewModelProtocol {
    func getCountryNamesList(countries: [Country]) -> [String]
    func getCytiesList(countryName: String) -> [String]

}

final class ProfileViewModel: ProfileViewModelProtocol {
    // MARK: Variables
    private let countryService: CountryServiceProtocol
    var countriesList: [Country] = []

    // MARK: Inits
    init(countryService: CountryServiceProtocol) {
        self.countryService = countryService
    }

    // MARK: Functions
    func viewIsLoaded() {
        countryService.getCountries { countries in
            self.countriesList = countries
        }
    }

    func getCountryNamesList(countries: [Country]) -> [String] {
        let countriesNames = countries.map { $0.name }
        return countriesNames
    }

    func getCytiesList(countryName: String) -> [String] {
        var selectedCities: [City] = []
        var citiesNames: [String] = []
        if let result = countriesList.first(where: { $0.name == countryName }) {
            selectedCities = result.cities
            for city in selectedCities {
                citiesNames.append(city.name)
            }
        }
        print(citiesNames)
        return citiesNames
    }
}
