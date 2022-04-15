//
//  SceneDelegate.swift
//  Diary
//
//  Created by 이해주 on 2022/04/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 윈도우 씬 가져오기
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 윈도우의 크기 설정
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 뷰 컨트롤러 인스턴스 가져오기
        let vc = TableViewController()
        
        // 네비게이션 컨트롤러 설정
//        let nacVC = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

