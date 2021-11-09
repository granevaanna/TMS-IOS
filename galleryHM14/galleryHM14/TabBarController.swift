//
//  TabBarController.swift
//  galleryHM14
//
//  Created by Анна Гранёва on 9.11.21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.tabsController?.tabBar.tabItems[0].title = "tab1"
        self.viewControllers?[0].title = "Галерея"
        self.viewControllers?[0].tabBarItem.tag = 1
        
        let item2 = ProfileViewController()
        let icon2 = UITabBarItem(title: "Профиль", image: UIImage(named: ""), tag: 2)
        item2.tabBarItem = icon2
        self.viewControllers?.append(item2)
    }
}
