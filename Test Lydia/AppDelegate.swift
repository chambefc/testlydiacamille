//
//  AppDelegate.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Instantiates the singleton for the PersistencyManager
        _ = PersistencyManager.shared
        _ = ReachabilityManager.shared

        prepareEntryController()
        
        return true
    }
    
    // Prepares the first ViewController to display
    func prepareEntryController() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let repository = UserRepository(
            networkClient: NetworkClient(),
            requestBuilder: RequestBuilder()
        )
        let viewModel = UserListViewModel(
            repository: repository
        )
        let controller = UsersListViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.setThemedAppearance()
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
    }
}

