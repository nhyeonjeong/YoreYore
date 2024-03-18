//
//  SceneDelegate.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // realm확인
        // 처음bookmark 탭에 진입한다면 realm에 BookmarkTable 종류별로 만들기
        let bookmarkRealm = BookmarkTableRepository.shared
        if bookmarkRealm.fetchItem().count == 0 {
            let cases = ClassifyList.allCases
            for rawValue in 0..<cases.count {
                bookmarkRealm.createItem(BookmarkTable(foodTypeRawValue: rawValue))
            }
        }
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let tabBarvc = UITabBarController()
        
        let firstNav = UINavigationController(rootViewController: SearchViewController())
        let secondNav = UINavigationController(rootViewController: BookmarkViewController())
        
        firstNav.tabBarItem = UITabBarItem(title: "레시피", image: Constants.Image.bowl, tag: 0)
        secondNav.tabBarItem = UITabBarItem(title: "북마크", image: Constants.Image.forkFill, tag: 1)
        
        tabBarvc.tabBar.tintColor = Constants.Color.point
        tabBarvc.tabBar.barTintColor = Constants.Color.background // 스크롤하면 색이 변경되는데 그때 색을 여기서 바꿀 수 있다.
        tabBarvc.viewControllers = [firstNav, secondNav]
        
        window?.rootViewController = tabBarvc
        window?.makeKeyAndVisible()
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

