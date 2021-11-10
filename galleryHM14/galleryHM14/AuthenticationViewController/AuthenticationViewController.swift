//
//  AuthenticationViewController.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 9.11.21.
//

import UIKit

final class AuthenticationViewController: UIViewController {

    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var logInButton: UIButton!
    
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
        if let surname = surnameTextField.text,
           let name = nameTextField.text,
           let ageString = ageTextField.text,
           let age = Double(ageString),
            age >= 1{
            
            UserDefaults.standard.set(surname, forKey: UserDefaults.surNameKey)
            UserDefaults.standard.set(name, forKey: UserDefaults.nameKey)
            UserDefaults.standard.set(Int(age), forKey: UserDefaults.ageKey)
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController{
                UserDefaults.standard.set(true, forKey: UserDefaults.authenticationKey)
                tabbar.modalPresentationStyle = .fullScreen
                present(tabbar, animated: true, completion: nil)
            }
            
        } else {
            ageTextField.layer.borderWidth = 1
            ageTextField.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
            ageTextField.text = ""
        }
        
    }
}

extension UserDefaults{
    static let surNameKey = "surName"
    static var surName: String{
        if let valueOfSurName = UserDefaults.standard.value(forKey: UserDefaults.surNameKey) as? String{
            return valueOfSurName
        }else {
            return ""
        }
    }
    
    static let nameKey = "name"
    static var name: String{
        if let valueOfname = UserDefaults.standard.value(forKey: UserDefaults.nameKey) as? String{
            return valueOfname
        }else {
            return ""
        }
    }
    
    static let ageKey = "age"
    static var age: Int{
        if let valueOfAge = UserDefaults.standard.value(forKey: UserDefaults.ageKey) as? Int{
            return valueOfAge
        }else {
            return 0
        }
    }
}
