//
//  TabBarViewController.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = UINavigationController(rootViewController: ViewController())
                
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)

        let secondViewController = UINavigationController(rootViewController: FavoriteViewController())

        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let tabBarList = [firstViewController, secondViewController]

        viewControllers = tabBarList
    }

}
