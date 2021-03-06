//
//  HomeWorkViewController.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.04.22.
//

import UIKit

final class HomeWorkViewController: UIViewController {
    @IBOutlet private weak var headerHomeWorkView: HeaderHomeWorkView!
    @IBOutlet private weak var activeHomeWork: ActiveHomeWork!
    @IBOutlet private weak var archiveHomeWorkView: ArchiveHomeWorkView!
    @IBOutlet private weak var homeWorkTabBar: UITabBar!
    @IBOutlet private weak var menuView: MenuView!
    @IBOutlet private weak var settingsHomeWorkView: SettingsHomeWorkView!
    
    private enum TabBarItemType: Int{
        case active = 1
        case archive = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeWorkTabBar.delegate = self
        headerHomeWorkView.delegate = self
        menuView.delegate = self
        activeHomeWork.delegate = self
        settingsHomeWorkView.delegate = self
        showActiveHomeWorkView()
        settingsForTabBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if !menuView.isHidden{
            menuView.isHidden = true
            enabledViews()
        }
        if !activeHomeWork.selectedHomeWorkView.isHidden{
            activeHomeWork.hideSelectedHomeWorkView()
            enabledViews()
        }
        if !settingsHomeWorkView.isHidden{
            settingsHomeWorkView.isHidden = true
            enabledViews()
        }
    }
    
    
    private func settingsForTabBar(){
        homeWorkTabBar.items?.first(where: { $0.tag == TabBarItemType.active.rawValue })?.selectedImage = UIImage(systemName: "star.fill")
        homeWorkTabBar.items?.first(where: { $0.tag == TabBarItemType.archive.rawValue })?.selectedImage = UIImage(systemName: "triangle.fill")
    }
    
    private func showActiveHomeWorkView(){
        activeHomeWork.isHidden = false
        archiveHomeWorkView.isHidden = true
    }
    private func showArchiveHomeWorkView(){
        activeHomeWork.isHidden = true
        archiveHomeWorkView.isHidden = false
    }
}

//MARK: - UITabBar
extension HomeWorkViewController: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            showActiveHomeWorkView()
        case 2:
            activeHomeWork.hideCreateHomeWorkView()
            showArchiveHomeWorkView()
        default:
            showActiveHomeWorkView()
        }
    }
}

//MARK: - HeaderHomeWorkViewDelegate
extension HomeWorkViewController: HeaderHomeWorkViewDelegate{
    func showSettingView() {
        settingsHomeWorkView.isHidden = false
        disableViews()
    }
    
    func showMenuView() {
        menuView.isHidden = false
        disableViews()
    }
}

//MARK: - MenuViewDelegate
extension HomeWorkViewController: MenuViewDelegate{
    func presentTimetableVC() {
        let timetable = UIStoryboard(name: "Timetable", bundle: nil)
        let timetableVC = timetable.instantiateViewController(withIdentifier: "TimetableViewController")
        timetableVC.modalPresentationStyle = .fullScreen
        timetableVC.modalTransitionStyle = .crossDissolve
        present(timetableVC, animated: true, completion: nil)
        menuView.isHidden = true
    }
    
    func presentHomeWorkVC() {
        menuView.isHidden = true
        enabledViews()
    }
}


//MARK: - ActiveHomeWorkDelegate
extension HomeWorkViewController: ActiveHomeWorkDelegate{
    func newArchiveHomeWorks(newArchiveHomeWorks: [HomeWorkModel]) {
        archiveHomeWorkView.appendArchiveHomeWorks(newArchiveHomeWorks: newArchiveHomeWorks)
        print(newArchiveHomeWorks)
    }
    
    func showDeleteHomeWorkAlert(at index: Int) {
        let alertController = UIAlertController(title: "", message: "Вы точно хотите удалить домашнее задание?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] ok in
            self?.activeHomeWork.removeFromActiveHomeWorks(at: index)
            self?.activeHomeWork.updateTableView()
            self?.enabledViews()
            
            if self?.activeHomeWork.countOfActiveHomeWorks() == 0{
                self?.activeHomeWork.showEmptyActiveHomeWorkView()
            } else {
                self?.activeHomeWork.showActiveHomeWorks()
            }
        }))
        alertController.addAction(UIAlertAction(title: "Нет", style: .default, handler: { [weak self] cancel in
            self?.enabledViews()
        }))
        present(alertController, animated: true, completion: nil) 
    }
    
    func enabledViews(){
        headerHomeWorkView.enabledHeaderView()
        activeHomeWork.enabledTableView()
        homeWorkTabBar.isUserInteractionEnabled = true
    }
    
    func disableViews(){
        headerHomeWorkView.disableHeaderView()
        activeHomeWork.disableTableView()
        homeWorkTabBar.isUserInteractionEnabled = false
    }
}


//MARK: - SettingsHomeWorkViewDelegate
extension HomeWorkViewController: SettingsHomeWorkViewDelegate{
    func showDeleteAllHomeWorkAlert() {
        settingsHomeWorkView.isHidden = true
        let alertController = UIAlertController(title: "", message: "Вы точно хотите очистить домашние задания?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] ok in
            self?.activeHomeWork.removeAllFromActiveHomeWorks()
            self?.enabledViews()
        }))
        alertController.addAction(UIAlertAction(title: "Нет", style: .default, handler: { [weak self] cancel in
                self?.enabledViews()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
