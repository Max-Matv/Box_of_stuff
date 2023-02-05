//
//  SceneDelegate.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 30.10.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [BoxViewController()]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }


}

