//
//  AuthenticationViewController.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 9.11.21.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLogInButtonState()
    }
    
    func updateLogInButtonState(){
        if let surname = surnameTextField.text,
           !surname.isEmpty,
           let name = nameTextField.text,
           !name.isEmpty,
           let age = ageTextField.text,
           !age.isEmpty{
            logInButton.isEnabled = true
        }else{
            logInButton.isEnabled = false
        }
    }
    
    @IBAction func textFieldsChanged(_ sender: UITextField) {
        updateLogInButtonState()
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
    }
}
