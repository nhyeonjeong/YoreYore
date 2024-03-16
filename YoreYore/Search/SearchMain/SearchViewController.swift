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
        setNavigationBar()
        configurePaging()
        configureTextField()
    }
    
    private func bindData() {
//        viewModel.recipeList.bind { recipes in
//            print(recipes)
//            print("classifyVIewcon collectionview 다시 그리기")
////            self.classifyVC.recipeList = recipes
////            self.classifyVC.mainView.foodCollectionView.reloadData()
//        }
    }
}

extension SearchViewController {
    func setNavigationBar() {
        navigationItem.title = "YoreYore"
    }
}

extension SearchViewController: PagingViewControllerDataSource, PagingViewControllerDelegate {
    // DateSource
    private func configurePaging() {
        mainView.pagingViewController.dataSource = self
        mainView.pagingViewController.delegate = self
    }
    // 1. 실행되는 순서
    func numberOfViewControllers(in pagingViewController: Parchment.PagingViewController) -> Int {
        print(#function)
        return viewModel.pagingItem.count
    }
    // 3,
    func pagingViewController(_: Parchment.PagingViewController, viewControllerAt index: Int) -> UIViewController {
//        print("pagingVC func foodType: \(classifyList.allCases[index])")
//        let classifyVC = ClassifyViewController([])
//        
//        viewModel.group[index].enter()
//        viewModel.inputFetchRecipe.value = ClassifyList.allCases[index]
//        viewModel.selectedFootType = ClassifyList.allCases[index]
        let classifyVC = ClassifyViewController(foodType: viewModel.classifyCases[index], searchText: mainView.searchTextField.text!)
        // 상세화면으로 전환
        classifyVC.goDetailRcp = { recipe in
            let vc = RecipeDetailViewController()
            vc.food = recipe
            vc.foodType = self.viewModel.selectedFootType
            self.navigationController?.pushViewController(vc, animated: true)
        }
        print(#function, classifyVC.foodType, classifyVC.searchFoodName)
        return classifyVC
    }
    // 2.
    func pagingViewController(_: Parchment.PagingViewController, pagingItemAt index: Int) -> Parchment.PagingItem {
        print(#function)
        return viewModel.pagingItem[index]
    }
    
    //Deleagate 당근
    // 메뉴 눌렸을 때 viewModel에 선택된 메뉴 저장
    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        for item in viewModel.pagingItem {
            if pagingItem.isEqual(to: item) {
                let index = item.index
                // 선택된 메뉴 알아내기,,
                viewModel.selectedFootType = viewModel.classifyCases[index]
                break
            }
        }
        
    }
}

extension SearchViewController: UITextFieldDelegate {
    private func configureTextField() {
        mainView.searchTextField.delegate = self
    }
    // 실시간 검색되도록
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            print("textField.text = nil")
            return
        }
        print(#function, textField.text!)
        mainView.pagingViewController.reloadData(around: viewModel.pagingItem[viewModel.selectedFootType.rawValue]) // textfield까지 같이 검색된다

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

