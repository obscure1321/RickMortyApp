//
//  SceneDelegate.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 08.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let isAuthorized = UserDefaults.standard.bool(forKey: "Authorized")
        
        if !isAuthorized {
            window.rootViewController = LoginScreenController()
//            window.rootViewController = BezVC()
        } else {
            window.rootViewController = UINavigationController(rootViewController: TabBarController())
//            window.rootViewController = BezVC()
        }
        
        window.makeKeyAndVisible()
        self.window = window
    }
}

