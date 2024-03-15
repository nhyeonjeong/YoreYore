//
//  SearchView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit
import SnapKit
import Parchment

struct FoodClassifyItem: PagingItem, Hashable {
    let classifyName: String
    func isBefore(item: Parchment.PagingItem) -> Bool {
        return true
    }
}
final class SearchView: BaseView {
    
    let searchBar = UISearchBar()
    
    let pagingViewController: PagingViewController = {
        let vc = PagingViewController()
        // 메뉴 커스텀
        vc.register(ClassifyMenuCollectionViewCell.self, for: FoodClassifyItem.self)
        vc.backgroundColor = Constants.Color.point ?? .point
        vc.menuItemSize = .selfSizing(estimatedWidth: 40, height: 70)
        vc.menuItemSpacing = 10
//        vc.menuHorizontalAlignment = .center
        return vc
    }()
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(pagingViewController.view)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}


