//
//  SettingsPicker.swift
//  lesson_19
//
//  Created by Анна Гранёва on 30.11.21.
//

import UIKit

protocol SettingsPickerDelegate: AnyObject{
    func addInformationToUserModel(string: String?, modelType: AdditionalInfoModelType)
}

final class SettingsPicker: UIViewController, UITextFieldDelegate {
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    
    weak var delegate: SettingsPickerDelegate?
    private let controllerType: AdditionalInfoModelType
    
    private let locationsData: [String] = ["Центральный",
                                          "Советский",
                                          "Первомайский",
                                          "Партизанский",
                                          "Заводской",
                                          "Ленинский",
                                          "Октябрьский",
                                          "Московский",
                                          "Фрунзенский"]
    
    private var locationsTempString: String?
    
    private let datePicker = UIDatePicker()
    private var locationsPicker: UIPickerView?
    
    init(type: AdditionalInfoModelType){
        controllerType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Type has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch controllerType{
        case .data:
            setupDatePicker()
        case .address:
            setupLocationsPicker()
        case .description:
            setupDescriptionsPicker()
        }
    }
    
    private func setupLocationsPicker() {
        locationsPicker = UIPickerView()
        locationsPicker?.dataSource = self
        locationsPicker?.delegate = self
        
        textField.inputAccessoryView = createdToolbar()
        textField.inputView = locationsPicker
    }
    
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        textField.inputAccessoryView = createdToolbar()
        textField.inputView = datePicker
    }
    
    private func setupDescriptionsPicker() {
        textField.isHidden = true
        textView.isHidden = false
    }
    
    func createdToolbar() -> UIToolbar{
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePickerAction))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        
        return toolbar
    }
    
    
    @objc func donePickerAction() {
        switch controllerType {
        case .data:
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            textField.text = formatter.string(from: datePicker.date)
            view.endEditing(true)
        case .address:
            textField.text = locationsTempString
            view.endEditing(true)
        case .description:
            view.endEditing(true)
        }
    }
    
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        switch controllerType{
        case .data:
            UserModel.shared.birthdayString = textField.text
            delegate?.addInformationToUserModel(string: textField.text, modelType: controllerType)
        case .address:
            UserModel.shared.locationString = textField.text
            delegate?.addInformationToUserModel(string: textField.text, modelType: controllerType)
        case .description:
            UserModel.shared.personalInfo = textView.text
            delegate?.addInformationToUserModel(string: textView.text, modelType: controllerType)
        }
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension SettingsPicker: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationsData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationsData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationsTempString = locationsData[row]
        textField.text = locationsTempString
    }
}
