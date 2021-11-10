//
//  ProfileViewController.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 9.11.21.
//

import UIKit
struct PersonModel{
    var surname:String
    var name:String
    var age:Int
}

final class ProfileViewController: UIViewController {
    @IBOutlet private weak var surnameStringLabel: UILabel!
    @IBOutlet private weak var nameStringLabel: UILabel!
    @IBOutlet private weak var ageIntLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var person = PersonModel(surname: UserDefaults.surName, name: UserDefaults.name, age: UserDefaults.age)
        setupWith(personModel: person)
    }
    
    func setupWith(personModel: PersonModel) {
        surnameStringLabel?.text = personModel.surname
        nameStringLabel?.text = personModel.name
        ageIntLabel?.text = "\(personModel.age)"
    }
    @IBAction func logOutButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Выход", message: "Вы уверены,что хотите выйти?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel) { action -> Void in
        })
        alert.addAction(UIAlertAction(title: NSLocalizedString("Да", comment: "Default action"), style: .default, handler: { _ in
            
            UserDefaults.standard.set(false, forKey: UserDefaults.authenticationKey)
            let authenticationViewController = AuthenticationViewController()
            authenticationViewController.modalPresentationStyle = .fullScreen
            self.present(authenticationViewController, animated: true, completion: nil)
            
            UserDefaults.standard.set("", forKey: UserDefaults.surNameKey)
            UserDefaults.standard.set("", forKey: UserDefaults.nameKey)
            UserDefaults.standard.set(0, forKey: UserDefaults.ageKey)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
