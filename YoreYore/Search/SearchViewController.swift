//
//  SearchViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit
import Parchment


final class SearchViewController: BaseViewController {

    let classifyList = ["한식", "중식", "일식"]
    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.pagingViewController.dataSource = self
    }
}


extension SearchViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: Parchment.PagingViewController) -> Int {
        return classifyList.count
    }
    
    func pagingViewController(_: Parchment.PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return ClassifyViewController(classifyFood: classifyList[index])
    }
    
    func pagingViewController(_: Parchment.PagingViewController, pagingItemAt index: Int) -> Parchment.PagingItem {
        return PagingIndexItem(index: index, title: classifyList[index])

    }
    
    
}
