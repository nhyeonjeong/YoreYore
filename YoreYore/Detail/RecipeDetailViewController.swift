//
//  RecipeDetailViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/11.
//

import UIKit
// Diffable로 테이블을 만들어보자!

final class RecipeDetailViewController: BaseViewController {

    var food: Recipe? = nil
    
    let tableView: UITableView = {
        let view = UITableView()
        
//        view.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        view.rowHeight = UITableView.automaticDimension
        return view
    }()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//    }
//
//    override func configureHierarchy() {
//        
//    }
//    
//    override func configureConstraints() {
//        <#code#>
//    }
    
}



