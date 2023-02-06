//
//  AppDelegate.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let navigatioContoller = UINavigationController.init()
        appCoordinator = AppCoordinator(navigationController: navigatioContoller)
        appCoordinator!.start()
        
        window!.rootViewController = navigatioContoller
        window!.makeKeyAndVisible()
        
        return true
    }
}

