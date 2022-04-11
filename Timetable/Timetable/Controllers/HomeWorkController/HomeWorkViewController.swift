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
    
    private enum TabBarItemType: Int{
        case active = 1
        case archive = 2
    }
    private var dataSource: [HomeWorkModel] = [HomeWorkModel(lessonName: "aaa", homeWork: "aaa", deadline: "22.02.2021", isDone: true, isActive: true), HomeWorkModel(lessonName: "bbb", homeWork: "bbb", deadline: "23.08.2021", isDone: false, isActive: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        homeWorkTabBar.delegate = self
        showActiveHomeWorkView()
        activeHomeWork.setActiveHomeWork(activeHomeWorks: getActiveHomeWorks())
        settingsForTabBar()
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
            showArchiveHomeWorkView()
        default:
            showActiveHomeWorkView()
        }
    }
}
