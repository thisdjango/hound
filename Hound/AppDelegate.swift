//
//  AppDelegate.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = TabBarViewController()
                
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)

        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
        
        return true
    }

}

