//
//  ProfileViewController.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-15.
//

import Foundation

//protocol ProfileViewControllerProtocol {
//    func getCitiesForSelectedCountry(country: String)
//    
//}

final class ProfileViewController: UIViewController {
    // MARK: Variables:
    private let viewModel: ProfileViewModel
    private var selectedCountry: String?
    private var selectedCity: String?
    private var selectedCites: [String] = []
    private let testArray = ["Male", "Female"]

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Расскажите о себе"
        label.textColor = UIColor(named: "color")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameView: TextFieldView = {
        let view = TextFieldView()
        view.configureInputField(on: .name)
        return view
    }()

    private lazy var surnameView: TextFieldView = {
        let view = TextFieldView()
        view.configureInputField(on: .surname)
        return view
    }()

    private lazy var selectSexLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажите свой пол"
        return label
    }()

    private lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["One", "Two"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(handle), for: .valueChanged)
        return segment
    }()

    private lazy var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажите свой возраст"
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        return picker
    }()

    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Country"
        return label
    }()

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        return label
    }()

    private lazy var countryTextField: UITextField  = {
        let textField = UITextField()
        textField.placeholder = "Select country"
        return textField
    }()

    private lazy var citiesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select your city"
        return textField
    }()

    private lazy var countryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private lazy var cityPiker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private lazy var nextButton: UIButton = {
        let button =  UIButton()
        button.setDimensions(width: 25, height: 25)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.button, for: .normal)
        button.layer.cornerRadius = 5
        button.tintColor = .lightGray
        return button
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dismissAndClosePickerView()
        initialSetup()
//        setupDatePicker()
        viewModel.viewIsLoaded() // вызываем функцию один раз при запуске когда загрузится вью
        selectedCites = viewModel.getCytiesList(countryName: "Japan")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: Inits
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        setupStackView(withViews: [UIView(),
                                   titleLabel,
                                   nameView, surnameView,
                                   selectSexLabel, segment,
                                   dateOfBirthLabel, datePicker,
                                   countryLabel, countryPicker,
                                   cityLabel, cityPiker,
                                   nextButton])
        setupConstraints()
    }
    private func initialSetup() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        nameView.textField.delegate = self
        surnameView.textField.delegate = self

        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryTextField.inputView = countryPicker

        cityPiker.delegate = self
        cityPiker.dataSource = self
        citiesTextField.inputView = cityPiker

    }
}

private extension ProfileViewController {
    // MARK: UI Functions
    func setupStackView(withViews views: [UIView]) { // cделать экстенш к функции стэк вью
        for view in views {
            stackView.addArrangedSubview(view)
        }
    }

    func setupConstraints() {
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0.0)
        contentViewHeightConstraint.priority = .defaultLow

        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.safeAreaLayoutGuide.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.safeAreaLayoutGuide.rightAnchor)

        contentView.anchor(top: scrollView.contentLayoutGuide.topAnchor,
                           left: scrollView.contentLayoutGuide.leftAnchor,
                           bottom: scrollView.contentLayoutGuide.bottomAnchor,
                           right: scrollView.contentLayoutGuide.rightAnchor)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0.0),

            stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Paddings.top),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Paddings.bottom),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Paddings.left),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Paddings.right),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0),

            contentViewHeightConstraint
        ])
    }

    func setupDatePicker() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .automatic
        } else {
            print("End")
        }

    }

    // MARK: Keyboard
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }

    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let contentInsert = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

        scrollView.contentInset = contentInsert
        scrollView.scrollIndicatorInsets = contentInsert
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func dismissAction() {
        view.endEditing(true)
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

    // MARK: UIPickerView
    func dismissAndClosePickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let button = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action: #selector(dismissAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        countryTextField.inputAccessoryView = toolBar
    }

}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameView.textField:
            surnameView.textField.becomeFirstResponder()
        case surnameView.textField:
            hideKeyboard()
        default:
            nameView.textField.becomeFirstResponder()
        }
        return true
    }
}

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPicker {
            return viewModel.getCountryNamesList(countries: viewModel.countriesList).count
        } else if pickerView == cityPiker {
            return selectedCites.count

        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPicker {
            return viewModel.getCountryNamesList(countries: viewModel.countriesList)[row]
        } else if pickerView == cityPiker {
            return selectedCites[row]
        }
        return "Error"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPicker {
            selectedCountry = viewModel.getCountryNamesList(countries: viewModel.countriesList)[row]
            countryTextField.text = selectedCountry
        } else if  pickerView == cityPiker {
            selectedCity = selectedCites[row]
            citiesTextField.text = selectedCity
        }
    }
}
