//
//  ClassifyViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit

// 넘어온 classifyFood 종류에 따라 collectionView 보이도록!
final class ClassifyViewController: BaseViewController {
    var goDetailRcp: ((Recipe) -> Void)? // 전체화면의 전환 위한 클로저
    var scrollFunc: ((CGPoint) -> Void)? // 스크롤할 때 상단뷰 위로 이동
    var foodType: ClassifyList
    var searchIngredients: [String]
    // Diffable사용
    private var dataSource: UICollectionViewDiffableDataSource<Int, Recipe>!
    
    let mainView = ClassifyView()
    private let viewModel = ClassifyViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputFetchRecipe.value = ClassifyViewModel.SearchWithIngredients(foodType: foodType, ingredients: searchIngredients)
        bindData()
        settingCollectionView()
    }
    
    private func settingCollectionView() {
        configurePrefetching()
        configureCollectionView()
        configureDataSource()
        updateSnapshot()
    }
    
    init(foodType: ClassifyList, searchIngredients: [String]) {
        self.foodType = foodType
        self.searchIngredients = searchIngredients
        super.init(nibName: nil, bundle: nil) // ?
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindData() {
        viewModel.recipeList.bind { _ in
            self.updateSnapshot()
        }
    }
}
extension ClassifyViewController {
    private func configureDataSource() {
        let foodCellRegistration = UICollectionView.CellRegistration<FoodCollectionViewCell, Recipe> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.foodCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
        
            let cell = collectionView.dequeueConfiguredReusableCell(using: foodCellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, Recipe>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel.recipeList.value)
        dataSource.apply(snapShot)
    }
}
// MARK: - UICollectionViewDelegate
extension ClassifyViewController: UICollectionViewDelegate {
    func configureCollectionView() {
        mainView.foodCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        goDetailRcp?(viewModel.recipeList.value[indexPath.item])
    }
//    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print(#function, indexPath)
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(#function, scrollView.contentOffset.y)
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 100 {
            scrollFunc?(scrollView.contentOffset)
        } else if scrollView.contentOffset.y > 100 {
            scrollFunc?(CGPoint(x: 0, y: 100))
        }
        if scrollView.contentOffset.y < 0 {
            scrollFunc?(CGPoint(x: 0, y: 0))
        }
    }
    
}

extension ClassifyViewController: UICollectionViewDataSourcePrefetching {
    func configurePrefetching() {
        mainView.foodCollectionView.prefetchDataSource = self
        mainView.foodCollectionView.keyboardDismissMode = .onDrag // 드래그되면 키보드 내리기
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        print(#function, indexPaths)
        for item in indexPaths {
            // 마지막 데이터가 아니라면 추가로 api통신
            if item.item == viewModel.recipeList.value.count - 6 && viewModel.totalRecipeCount > item.item {
                // endIdx가 viewMdodel.totalRecipeCount을 초과하지는 않는지
                viewModel.setApiIndex()
                viewModel.inputFetchRecipe.value =  ClassifyViewModel.SearchWithIngredients(foodType: foodType, ingredients: searchIngredients)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(#function)
    }

}
