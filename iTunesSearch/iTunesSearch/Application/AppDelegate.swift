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
    private var appCoordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(String.localizedStringWithFormat(Constants.Alert.greeting, "Admin", "\(Date.now)"))
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else { return false }
        
        let routerComponents = RouterComponents()
        let appRouter = AppRouter(routerComponents: routerComponents)
        appCoordinator = AppCoordinator(window: window, router: appRouter)
        appCoordinator!.start()
        
        return true
    }
}

