//
//  ViewController.swift
//  testApplication33
//
//  Created by Анна Гранёва on 24.01.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var currentController: ControllerType = .start
    private var dataSource: [CellType] = []
    var users: [UserModel] = [UserModel.firstUser]
    static var currentEnterLogin = ""
    static var currentEnterpassword = ""
    
    private enum ControllerType{
        case start
        case comeIn
        case registration
    }
    
    enum CellType: String{
        case login = "Вход"
        case registration = "Регистрация"
        case userName = "Логин"
        case password = "Пароль"
        case comeIn = "Войти"
        case register = "Зарегистрироваться"
        case back = "Назад"
    }
    
    private func manageDataSource() {
        switch currentController {
        case .start:
            dataSource = [.login, .registration]
        case .comeIn:
            dataSource = [.userName, .password, .comeIn, .back]
        case .registration:
            dataSource = [.userName, .password, .register, .back]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSettings()
        manageDataSource()
    }
    
    func tableSettings(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StartTableCell", bundle: nil), forCellReuseIdentifier: StartTableCell.identifier)
    }
    func setupAlertWith(message: String){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentController {
        case .start:
            return 2
        case .comeIn:
            return 4
        case .registration:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StartTableCell.identifier, for: indexPath) as! StartTableCell
        
//        if dataSource[indexPath.row] == .comeIn || dataSource[indexPath.row] == .register{
//            if ViewController.currentEnterLogin.isEmpty || ViewController.currentEnterpassword.isEmpty{
//                cell.hideButton()
//            } else{
//                cell.showButton()
//            }
//        }
        
        cell.setup(buttonType: dataSource[indexPath.row])
        cell.delegate = self
        return cell
    }
}


//MARK: - StartTableCellDelegate
extension ViewController: StartTableCellDelegate{
    func showSomething(pressedCellType: CellType) {
        switch pressedCellType {
        case .login:
            currentController = .comeIn
            manageDataSource()
            tableView.reloadData()
        case .registration:
            currentController = .registration
            manageDataSource()
            tableView.reloadData()
        case .userName:
            let alertController = UIAlertController(title: "", message: "Введите логин", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
            alertController.addTextField { textField in
                textField.placeholder = "Логин"
                if !ViewController.currentEnterLogin.isEmpty{
                    textField.text = ViewController.currentEnterLogin
                }
            }
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { save in
                if let textFieldText = alertController.textFields?.first?.text, !textFieldText.isEmpty{
                    ViewController.currentEnterLogin = textFieldText
                    self.tableView.reloadData()
                }
            }))
            present(alertController, animated: true, completion: nil)
        case .password:
            let alertController = UIAlertController(title: "", message: "Введите пароль", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Отменить", style: .default, handler: nil))
            alertController.addTextField { textField in
                textField.placeholder = "Пароль"
            }
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { save in
                if let textFieldText = alertController.textFields?.first?.text, !textFieldText.isEmpty{
                    ViewController.currentEnterpassword = textFieldText
                    self.tableView.reloadData()
                }
            }))
            present(alertController, animated: true, completion: nil)
        case .comeIn:
            if !ViewController.currentEnterLogin.isEmpty, !ViewController.currentEnterpassword.isEmpty{
                if !users.compactMap({$0.userName == ViewController.currentEnterLogin && $0.password == ViewController.currentEnterpassword}).filter({$0 == true}).isEmpty{
                    setupAlertWith(message: "Вход выполнен успешно!")
                    ViewController.currentEnterLogin = ""
                    ViewController.currentEnterpassword = ""
                    tableView.reloadData()
                }else{
                    setupAlertWith(message: "Такого пользователя не существует!")
                }
            } else{
                setupAlertWith(message: "Заполните все поля!")
            }
        case .register:
            if !ViewController.currentEnterLogin.isEmpty, !ViewController.currentEnterpassword.isEmpty{
                if users.compactMap({$0.userName == ViewController.currentEnterLogin}).filter({$0 == true}).isEmpty{
                    users.append(UserModel(userName: ViewController.currentEnterLogin, password: ViewController.currentEnterpassword))
                    setupAlertWith(message: "Регистрация прошла успешно!")
                    ViewController.currentEnterLogin = ""
                    ViewController.currentEnterpassword = ""
                    tableView.reloadData()
                }else{
                    setupAlertWith(message: "Такой пользователь уже существует!")
                }
            } else{
                setupAlertWith(message: "Заполните все поля!")
            }
        case .back:
            ViewController.currentEnterLogin = ""
            ViewController.currentEnterpassword = ""
            currentController = .start
            manageDataSource()
            tableView.reloadData()
        }
    }
}
