//
//  ProfileViewModel.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-15.
//

import Foundation

protocol ProfileViewModelProtocol {
    func getCytiesList(countryName: String) -> [String]

}

final class ProfileViewModel: ProfileViewModelProtocol {
    // MARK: Variables
    private let countryService: CountryServiceProtocol
    private var countriesList: [Country] = []
    private var selectedCities: [City] = []
    private var selectedString: [String] = []

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

    func getCytiesList(countryName: String) -> [String] {
        var citiesList: [String] = []
        if let result = countriesList.first(where: { $0.name == countryName }) {
            selectedCities = result.cities
            for city in selectedCities {
                citiesList.append(city.name)
            }
        }
        print(citiesList)
        return citiesList
    }
}
