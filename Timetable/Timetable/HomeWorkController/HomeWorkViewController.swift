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
    
    
    private enum TabBarItemType: Int{
        case active = 1
        case archive = 2
    }
    private var dataSource: [HomeWorkModel] = [HomeWorkModel(lessonName: "aaa", homeWork: "aaa", deadline: "22.02.2021", isDone: true, isActive: true), HomeWorkModel(lessonName: "bbb", homeWork: "bbb", deadline: "23.08.2021", isDone: false, isActive: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        homeWorkTabBar.delegate = self
        headerHomeWorkView.delegate = self
        menuView.delegate = self
        activeHomeWork.delegate = self
        showActiveHomeWorkView()
        activeHomeWork.setActiveHomeWork(activeHomeWorks: getActiveHomeWorks())
        settingsForTabBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if !menuView.isHidden{
            menuView.isHidden = true
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
    
    private func getActiveHomeWorks() -> [HomeWorkModel]{
        return dataSource.filter({ $0.isActive == true })
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
