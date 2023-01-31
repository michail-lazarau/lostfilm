//
//  ProfileViewModel.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-15.
//

import Foundation

protocol ProfileViewModelProtocol {
    func viewIsLoaded()
    func didEnterNameTextFieldWithString(nameViewString: String)
    func didEnterSurnameTextFieldWithString(surnameViewString: String)
    func getCitiesList(countryName: String) -> [String]
    func checkButtonStatus(nameViewString: String, surnameViewString: String, countyPickerString: String, cityPickerString: String)
    func nextButtonAction()
    func viewReady(_ view: ProfileViewProtocol)
    var countriesList: [Country] { get }
    var view: ProfileViewProtocol? { get }
}

final class ProfileViewModel {
    // MARK: Variables
    weak var view: ProfileViewProtocol?
    private let countryService: CountryServiceProtocol
    var countriesList: [Country] = []
    private let debouncer: DebouncerProtocol
    private let router: DetailInformationProtocol

    // MARK: Inits
    init(countryService: CountryServiceProtocol, debouncer: DebouncerProtocol, router: DetailInformationProtocol) {
        self.countryService = countryService
        self.debouncer = debouncer
        self.router = router
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    func nextButtonAction() {
        router.openPhotoViewController()
    }

    func viewReady(_ view: ProfileViewProtocol) {
        self.view = view
    }

    func checkButtonStatus(nameViewString: String, surnameViewString: String, countyPickerString countryPickerString: String, cityPickerString: String) {
        if Validators.nickname.validate(nameViewString)  && Validators.nickname.validate(surnameViewString),
           !countryPickerString.isEmpty && !cityPickerString.isEmpty {
            view?.setButtonEnabled(true)
        } else {
            view?.setButtonEnabled(false)
        }
    }

    // MARK: Functions
    func viewIsLoaded() {
        countryService.getCountries { countries in
            self.countriesList = countries
        }
    }

    func getCitiesList(countryName: String) -> [String] {
        var selectedCities: [City] = []
        var citiesNames: [String] = []
        if let result = countriesList.first(where: { $0.name == countryName }) {
            selectedCities = result.cities
            for city in selectedCities {
                citiesNames.append(city.name)
            }
        }
        return citiesNames
    }

    func didEnterNameTextFieldWithString(nameViewString: String) {
        debouncer.debounce { [weak self] in
            if Validators.nickname.validate(nameViewString) {
                self?.view?.sendNameConfirmationMessage(ValidationConfirmation.validName, color: .green)
            } else {
                self?.view?.sendNameErrorMessage(ValidationErrors.invalidName, color: .red)
            }
        }
    }

    func didEnterSurnameTextFieldWithString(surnameViewString: String) {
        debouncer.debounce { [weak self] in
            if Validators.nickname.validate(surnameViewString) {
                self?.view?.sendSurnameConfirmationMessage(ValidationConfirmation.validSurname, color: .green)
            } else {
                self?.view?.sendSurnameErrorMessage(ValidationErrors.invalidSurname, color: .red)
            }
        }
    }
}
