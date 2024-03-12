//
//  SearchViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit
import Parchment

final class SearchViewController: BaseViewController {
    
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
        viewModel.recipeList.bind { recipes in
            print(recipes)
            print("classifyVIewcon collectionview 다시 그리기")
//            self.classifyVC.recipeList = recipes
//            self.classifyVC.mainView.foodCollectionView.reloadData()
        }
    }
}

extension SearchViewController: PagingViewControllerDataSource {
    // 1.
    func numberOfViewControllers(in pagingViewController: Parchment.PagingViewController) -> Int {
        return ClassifyList.allCases.count
    }
    // 3,
    func pagingViewController(_: Parchment.PagingViewController, viewControllerAt index: Int) -> UIViewController {
//        print("pagingVC func foodType: \(classifyList.allCases[index])")
//        let classifyVC = ClassifyViewController([])
//        
//        viewModel.group[index].enter()
//        viewModel.inputFetchRecipe.value = ClassifyList.allCases[index]
//        viewModel.selectedFootType = ClassifyList.allCases[index]
//        
        let classifyVC = ClassifyViewController(ClassifyList.allCases[index])
        classifyVC.goDetailRcp = { recipe in
            let vc = RecipeDetailViewController()
            vc.food = recipe
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return classifyVC
    }
    // 2.
    func pagingViewController(_: Parchment.PagingViewController, pagingItemAt index: Int) -> Parchment.PagingItem {
        return PagingIndexItem(index: index, title: ClassifyList.allCases[index].classifyName)
    }
}

extension SearchViewController: UISearchBarDelegate {
    // return 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBar.value = searchBar.text!
    }
}
