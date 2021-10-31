//
//  FirstScreen.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 29.10.21.
//

import UIKit

final class FirstScreen: UIViewController{
    @IBOutlet weak var appDescription: UILabel!
    @IBOutlet private weak var buttonToTable: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Список студентов"
        appDescription.text = "Здесь вы можете посмотреть список студентов выбранного курса по группам"
        customizeButtonToTable()
    }
    
    func customizeButtonToTable(){
        buttonToTable.titleLabel?.text = "3 курс"
        buttonToTable.titleLabel?.textColor = .white
        buttonToTable.titleLabel?.font = .systemFont(ofSize: 40)
        buttonToTable.backgroundColor = UIColor(displayP3Red: 0.88, green: 0.67, blue: 0.63, alpha: 1)
    }
}
