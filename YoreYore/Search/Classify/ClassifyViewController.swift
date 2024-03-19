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
extension ClassifyViewController: UICollectionViewDelegate {
    func configureCollectionView() {
        mainView.foodCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        view.endEditing(true)
        goDetailRcp?(viewModel.recipeList.value[indexPath.item])
    }
}
