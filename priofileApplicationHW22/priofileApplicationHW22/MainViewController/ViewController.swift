//
//  ViewController.swift
//  priofileApplicationHW22
//
//  Created by Анна Гранёва on 5.12.21.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NameTableCell", bundle: nil), forCellReuseIdentifier: NameTableCell.identifier)
        tableView.register(UINib(nibName: "DateOfBirthTableCell", bundle: nil), forCellReuseIdentifier: DateOfBirthTableCell.identifier)
        tableView.register(UINib(nibName: "PhotoTableCell", bundle: nil), forCellReuseIdentifier: PhotoTableCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(openEditViewController), name: .openEditViewController, object: nil)
    }
    
    
    @objc func openEditViewController() {
        let editViewController = EditViewController()
        editViewController.delegate = self
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NameTableCell.identifier, for: indexPath) as! NameTableCell
            cell.setupWith()
            cell.selectionStyle = .none
            return cell
        }  else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableCell.identifier, for: indexPath) as! DateOfBirthTableCell
            cell.setupWith()
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCell.identifier, for: indexPath) as! PhotoTableCell
            cell.setupWith()
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: - Notification.Name
extension Notification.Name {
    static let openEditViewController = Notification.Name("openEditViewController")
}

//MARK: - EditViewControllerDelegate
extension ViewController: EditViewControllerDelegate{
    func editInformation() {
        tableView.reloadData()
    }
}

