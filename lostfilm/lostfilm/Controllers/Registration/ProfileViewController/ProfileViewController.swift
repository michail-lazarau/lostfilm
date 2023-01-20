//
//  ProfileViewController.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-15.
//

import Foundation

final class ProfileViewController: UIViewController {
    // MARK: Variables:
    private let viewModel: ProfileViewModelProtocol

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
        label.text =  Texts.Titles.aboutYourself
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
        label.text = Texts.Titles.gender
        return label
    }()

    private lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: [Texts.Placeholders.male, Texts.Placeholders.female])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(handle), for: .valueChanged)
        return segment
    }()

    private lazy var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.Titles.age
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        return picker
    }()

    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.Titles.country
        return label
    }()

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.Titles.city
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
        let button = LostfilmButton(title: Texts.Buttons.next)
        button.indicator.color = .white
        return button
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewReady(self)
        setupView()
        dismissAndClosePickerView()
        initialSetup()
        viewModel.viewIsLoaded()
        bindTextFields()
        cityLabel.isHidden = true
        citiesTextField.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotification()
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
        stackView.setupSubViews(withViews: [UIView(), titleLabel,
                                   nameView, surnameView,
                                   selectSexLabel, segment,
                                   dateOfBirthLabel, datePicker,
                                   countryLabel, countryTextField,
                                   cityLabel, citiesTextField,
                                   nextButton])
        setupConstraints()
    }
    private func initialSetup() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nameView.textField.delegate = self
        surnameView.textField.delegate = self
        nameView.textField.returnKeyType = .next
        surnameView.textField.returnKeyType = .done

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

    func showCitySection() {
        cityLabel.isHidden = false
        citiesTextField.isHidden = false
    }

    // MARK: Keyboard
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func nextButtonPressed() {
        viewModel.nextButtonAction()
    }

    func bindTextFields() {
        nextButton.isEnabled = false
        nameView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        surnameView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        countryTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .allEvents)
        citiesTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .allEvents)
    }

    @objc func handle(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Do smth")
        case 1:
            print("Do smth")
        default:
            print("Do smth")
        }
    }

    // MARK: UIPickerView
    func dismissAndClosePickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let button = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action: #selector(hideKeyboard))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        countryTextField.inputAccessoryView = toolBar
        citiesTextField.inputAccessoryView = toolBar
    }

    // MARK: Logic
    func didChangeButtonStatus(nameViewString: String, surnameViewString: String, countryPickerString: String,
                               cityPickerString: String) {
        viewModel.checkButtonStatus(nameViewString: nameViewString, surnameViewString: surnameViewString,
                                    countyPickerString: countryPickerString, cityPickerString: cityPickerString)
    }

    func didChangeInputNameTextField(nameViewString: String) {
        viewModel.didEnterNameTextFieldWithString(nameViewString: nameViewString)
    }

    func didChangeInputSurnameTextField(surnameViewString: String) {
        viewModel.didEnterSurnameTextFieldWithString(surnameViewString: surnameViewString)
    }

    @objc func textFieldEditingChanged(sender: UITextField) {
        switch sender {
        case nameView.textField:
            didChangeInputNameTextField(nameViewString: nameView.textField.text ?? "")
        case surnameView.textField:
            didChangeInputSurnameTextField(surnameViewString: surnameView.textField.text ?? "")
            didChangeButtonStatus(nameViewString: nameView.textField.text ?? "", surnameViewString: surnameView.textField.text ?? "",
                                  countryPickerString: countryTextField.text ?? "", cityPickerString: citiesTextField.text ?? "")
        default:
            nameView.textField.resignFirstResponder()
        }
        didChangeButtonStatus(nameViewString: nameView.textField.text ?? "", surnameViewString: surnameView.textField.text ?? "",
                              countryPickerString: countryTextField.text ?? "", cityPickerString: citiesTextField.text ?? "")
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func setButtonEnabled(_ isEnable: Bool) {
        DispatchQueue.main.async { [weak nextButton] in
            nextButton?.isEnabled = isEnable
        }
    }

    func sendNameConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        nameView.setConfirmationState(with: confirmationMessage, color: color)
    }

    func sendSurnameConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        surnameView.setConfirmationState(with: confirmationMessage, color: color)
    }

    func sendNameErrorMessage(_ errorMessage: String, color: UIColor) {
        nameView.setErrorState(with: errorMessage, color: color)
    }

    func sendSurnameErrorMessage(_ errorMessage: String, color: UIColor) {
        surnameView.setErrorState(with: errorMessage, color: color)
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
            return viewModel.countriesList.count
        } else if  pickerView == cityPiker {
            return viewModel.getCitiesList(countryName: countryTextField.text ?? "").count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPicker {
            return viewModel.countriesList[row].name
        } else if pickerView == cityPiker {
            return viewModel.getCitiesList(countryName: countryTextField.text ?? "")[row]
        }
        return "Error"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPicker {
            countryTextField.text = viewModel.countriesList[row].name // проверка на нил
            citiesTextField.text = viewModel.getCitiesList(countryName: countryTextField.text ?? "").first
            showCitySection()
        } else if pickerView == cityPiker {
            citiesTextField.text = viewModel.getCitiesList(countryName: countryTextField.text ?? "")[row]
        }
    }
}
