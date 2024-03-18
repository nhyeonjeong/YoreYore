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
    var searchFoodName: String
    
    let mainView = ClassifyView()
    private let viewModel = ClassifyViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel.inputFetchRecipe.value = ClassifyViewModel.SearchWithType(foodType: foodType, foodName: searchFoodName)
        bindData()
    }
    init(foodType: ClassifyList, searchText: String) {
        self.foodType = foodType
        self.searchFoodName = searchText
        super.init(nibName: nil, bundle: nil) // ?
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindData() {
        viewModel.recipeList.bind { _ in
            self.mainView.foodCollectionView.reloadData()
        }
    }
}

extension ClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        mainView.foodCollectionView.delegate = self
        mainView.foodCollectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipeList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.identifier, for: indexPath) as? FoodCollectionViewCell else {
            print("FoodCollectionViewCell로 변경 실패")
            return UICollectionViewCell()
        }
        
        cell.configureCell(recipe: viewModel.recipeList.value[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        goDetailRcp?(viewModel.recipeList.value[indexPath.item])
    }
    
    
}
