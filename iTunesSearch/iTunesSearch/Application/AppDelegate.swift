//
//  AppDelegate.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import UIKit
import TestStatic
import TestFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(String.localizedStringWithFormat(Constants.Alert.greeting, "Admin", "\(Date.now)"))
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else { return false }
        
        let navigationController = UINavigationController()
        let appRouter = AppRouter(navigationController: navigationController)
        appCoordinator = AppCoordinator(window: window, router: appRouter)
        appCoordinator!.start()
        
        TestStatic()
        TestFramework()
        return true
    }
}

