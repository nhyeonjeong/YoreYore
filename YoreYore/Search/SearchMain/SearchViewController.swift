//
//  SearchViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit
import Parchment


final class SearchViewController: BaseViewController {

    enum classifyList: Int, CaseIterable {
        case dessert // 후식
        case sideDish // 반찬
        case mainDish // 밥
//        case soup // 찌개또는 국
        
        var classifyName: String{
            switch self {
            case .dessert:
                return "후식"
            case .sideDish:
                return "반찬"
            case .mainDish:
                return "밥"
//            case .soup:
//                return "국&찌개"
            }
        }
        
    }
    let mainView = SearchView()
    let viewModel = SearchViewModel()
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        mainView.pagingViewController.dataSource = self
    }
    
    private func bindData() {
        viewModel.recipeList.bind { _ in
            self.mainView.pagingViewController.reloadData()
        }
    }
}

extension SearchViewController: PagingViewControllerDataSource {
    // 1.
    func numberOfViewControllers(in pagingViewController: Parchment.PagingViewController) -> Int {
        return classifyList.allCases.count
    }
    
    func pagingViewController(_: Parchment.PagingViewController, viewControllerAt index: Int) -> UIViewController {
        print("pagingVC func foodType: \(classifyList.allCases[index])")
        viewModel.selectedFootType = classifyList.allCases[index].classifyName
        return ClassifyViewController(foodType: classifyList.allCases[index].classifyName)
    }
    // 2.
    func pagingViewController(_: Parchment.PagingViewController, pagingItemAt index: Int) -> Parchment.PagingItem {
        print(#function)
        return PagingIndexItem(index: index, title: classifyList.allCases[index].classifyName)

    }
}

extension SearchViewController: UISearchBarDelegate {
    // return 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBar.value = searchBar.text!
    }
}
