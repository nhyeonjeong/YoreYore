//
//  LaunchScreenViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/24.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    let lottieView = LottieAnimationView(name: "launchScreen")
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(lottieView)
        view.backgroundColor = Constants.Color.secondPoint
        lottieView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
       
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut) {
            print("launchAnimation play")
            self.lottieView.loopMode = .repeat(5) // .repeat(3)
    //        lottieView.animationSpeed = 0.5
            self.lottieView.play()
        } completion: { _ in
            
            let tabBarvc = UITabBarController()
            
            let firstNav = UINavigationController(rootViewController: SearchViewController())
            let secondNav = UINavigationController(rootViewController: BookmarkViewController())
            
            firstNav.tabBarItem = UITabBarItem(title: "레시피", image: Constants.Image.bowl, tag: 0)
            secondNav.tabBarItem = UITabBarItem(title: "북마크", image: Constants.Image.forkFill, tag: 1)
            
            tabBarvc.tabBar.tintColor = Constants.Color.point
            tabBarvc.tabBar.barTintColor = Constants.Color.background // 스크롤하면 색이 변경되는데 그때 색을 여기서 바꿀 수 있다.
            tabBarvc.viewControllers = [firstNav, secondNav]
            tabBarvc.modalPresentationStyle = .fullScreen
            self.present(tabBarvc, animated: false)
        }
    }
}
