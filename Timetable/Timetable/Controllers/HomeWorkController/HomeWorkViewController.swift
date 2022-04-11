//
//  HomeWorkViewController.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.04.22.
//

import UIKit

class HomeWorkViewController: UIViewController {
    @IBOutlet private weak var headerHomeWorkView: HeaderHomeWorkView!
    @IBOutlet private weak var activeHomeWork: ActiveHomeWork!
    @IBOutlet private weak var archiveHomeWorkView: ArchiveHomeWorkView!
    @IBOutlet private weak var homeWorkTabBar: UITabBar!
    
    private enum TabBarItemType: Int{
        case active = 1
        case archive = 2
    }
    private var dataSource: [HomeWorkModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        homeWorkTabBar.delegate = self
        showActiveHomeWorkView()
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
            showArchiveHomeWorkView()
        default:
            showActiveHomeWorkView()
        }
    }
}
