//
//  BaseViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background // 배경은 기본적으로 background
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureView() {
        
    }
}
