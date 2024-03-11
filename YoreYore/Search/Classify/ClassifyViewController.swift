//
//  ClassifyViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit

// 넘어온 classifyFood 종류에 따라 collectionView 보이도록!
final class ClassifyViewController: BaseViewController {
    private let foodType: String
    
    private let mainView = ClassifyView()
    private let viewModel = ClassifyViewModel()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        // 처음 뷰를 띄울때만 API통신을 하고 싶어서..!
        print("ClassifyVC viewDidLoad foodtype: \(foodType)")
        viewModel.inputFetchRecipe.value = foodType
        bindData()
    }
    init(foodType: String) {
        self.foodType = foodType
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
        let vc = RecipeDetailViewController()
        vc.food = viewModel.recipeList.value[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
