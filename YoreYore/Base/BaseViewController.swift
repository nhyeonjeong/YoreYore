//
//  BaseViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit

class BaseViewController: UIViewController {
    // 커스텀 백버튼
    let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(clickBackButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background // 배경은 기본적으로 background
        backBarButtonItem.tintColor = Constants.Color.point
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    @objc func clickBackButton() {
        self.dismiss(animated: true)
    }
    
    func configureHierarchy() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureView() {
        
    }
}
