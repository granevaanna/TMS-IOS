//
//  DataPickerController.swift
//  lesson_19
//
//  Created by Анна Гранёва on 22.11.21.
//

import UIKit

protocol SettingsPickerDelegate: AnyObject{
    func addInformationToUserModel(string: String?, modelType: AdditionalInfoModelType)
}

class SettingsPicker: UIViewController, UITextFieldDelegate {
    @IBOutlet private weak var textField: UITextField!
    weak var delegateDataPicker: SettingsPickerDelegate?
    
    static var identifier: AdditionalInfoModelType = .data
    
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SettingsPicker.identifier == .data{
            showDatePicker()
        } else{
            textField.isUserInteractionEnabled = true
        }
    }
    
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        textField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        UserModel.shared.birthdayString = textField.text
        delegateDataPicker?.addInformationToUserModel(string: UserModel.shared.birthdayString, modelType: SettingsPicker.identifier)
        navigationController?.popViewController(animated: true)
    }
}

