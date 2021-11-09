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

class ProfileViewController: UIViewController {
    @IBOutlet weak var surnameStringLabel: UILabel!
    @IBOutlet weak var nameStringLabel: UILabel!
    @IBOutlet weak var ageIntLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupWith(model: PersonModel) {
        surnameStringLabel.text = model.surname
        nameStringLabel.text = model.name
        ageIntLabel.text = "\(model.age)"
    }
}
