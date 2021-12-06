//
//  EditViewController.swift
//  priofileApplicationHW22
//
//  Created by Анна Гранёва on 6.12.21.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject{
    func editInformation()
}

final class EditViewController: UIViewController {
    
    static var controllerType: EditViewControllerType = .name
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var photoImage: UIImageView!
    
    @IBOutlet private weak var addPhotoButton: UIButton!
    
    weak var delegate: EditViewControllerDelegate?
    
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch EditViewController.controllerType{
        case .name:
            textField.placeholder = "Введите имя"
        case .dateOfBirth:
            textField.placeholder = "Нажмите для выбора даты рождения"
            setupDatePicker()
        case .photo:
            textField.isHidden = true
            photoImage.isHidden = false
            addPhotoButton.isEnabled = true
            textField.placeholder = "Введите название фото"
        }
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        textField.inputAccessoryView = createdToolbar()
        textField.inputView = datePicker
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
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        textField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
    
    @IBAction func addPhotoButtonAction(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        switch EditViewController.controllerType{
        case .name:
            if let textFieldText = textField.text, !textFieldText.isEmpty{
                defaults.set(textFieldText, forKey: NameTableCell.identifier)
            }
        case .dateOfBirth:
            if let textFieldText = textField.text, !textFieldText.isEmpty{
                defaults.set(textFieldText, forKey: DateOfBirthTableCell.identifier)
            }
        case .photo:
            
            if let imageData = photoImage.image?.jpegData(compressionQuality: 0) {
                defaults.set(imageData, forKey: PhotoTableCell.identifier)
            }
            
          
        }
        delegate?.editInformation()
        navigationController?.popViewController(animated: true)
        
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[ .editedImage] as? UIImage {
            photoImage.image = image
        }
        picker.dismiss(animated: true)
    }
}
