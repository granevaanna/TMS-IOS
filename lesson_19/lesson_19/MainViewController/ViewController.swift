//
//  ViewController.swift
//  lesson_19
//
//  Created by Анна Гранёва on 22.11.21.
//

import UIKit

private enum SettingSection{
    case mainInfo
    case addingInfo
}

final class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: [SettingSection] = [.mainInfo, .addingInfo]
    private var additionalDataSource: [AdditionalInfoModel] = [
        AdditionalInfoModel(sectionName: "Дата рождения", sectionValue: UserModel.shared.birthdayString, modelType: .data),
        AdditionalInfoModel(sectionName: "Адрес", sectionValue: UserModel.shared.locationString, modelType: .address),
        AdditionalInfoModel(sectionName: "О себе", sectionValue: UserModel.shared.personalInfo, modelType: .description)]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apple ID"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserDataCell", bundle: nil), forCellReuseIdentifier: UserDataCell.identifier)
        
        tableView.register(UINib(nibName: "TableViewCellWithTablel", bundle: nil), forCellReuseIdentifier: TableViewCellWithTablel.identifier)
        createUser()
        let vc = SettingsPicker(nibName: "DataPickerController", bundle: nil)
        vc.delegateDataPicker = self
    }
    
    private func createUser(){
        UserModel.shared.profileName = "Anna"
        UserModel.shared.profileEmail = "granevaanna7@gmail.com"
        UserModel.shared.profileImage = UIImage(named: "profile")
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row]{
        case .mainInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserDataCell.identifier, for: indexPath) as! UserDataCell
            cell.setupCellData()
            return cell
        case .addingInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellWithTablel.identifier, for: indexPath) as! TableViewCellWithTablel
            cell.setupWith(data: additionalDataSource)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return CGFloat(additionalDataSource.count * 64)
        }else{
            return UITableView.automaticDimension
        }
    }
}


//MARK: - TableViewCellWithTablelDelegate
extension ViewController: TableViewCellWithTablelDelegate{
    func birtdayAction(model: AdditionalInfoModel) {
        let dataPickerController = SettingsPicker()
        SettingsPicker.identifier = model.modelType
        dataPickerController.delegateDataPicker = self
        self.navigationController?.pushViewController(dataPickerController, animated: true)
    }
}


//MARK: - DataPickerControllerDelegate
extension ViewController: SettingsPickerDelegate{
    func addInformationToUserModel(string: String?, modelType: AdditionalInfoModelType) {
        additionalDataSource.first(where: {$0.modelType == modelType})?.sectionValue = string
        tableView.reloadData() 
    }
}

