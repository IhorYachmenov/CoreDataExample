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
        
        let coordinatorComponents = CoordinatorComponents()
        let appRouter = AppRouter(coordinatorComponents: coordinatorComponents)
        appCoordinator = AppCoordinator(window: window, router: appRouter)
        appCoordinator!.start()
        
        return true
    }
}

