//
//  ClassifyViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit

// 넘어온 classifyFood 종류에 따라 collectionView 보이도록!
final class ClassifyViewController: BaseViewController {
    private let classifyFood: String
    
    let foodList = ["된장찌개", "김치찌개", "하하", "우우"]
    
    private let mainView = ClassifyView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    init(classifyFood: String) {
        self.classifyFood = classifyFood
        super.init(nibName: nil, bundle: nil) // ?
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        mainView.classifyCollectionView.delegate = self
        mainView.classifyCollectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.identifier, for: indexPath) as? FoodCollectionViewCell else {
            print("FoodCollectionViewCell로 변경 실패")
            return UICollectionViewCell()
        }
        
        cell.configureCell(text: foodList[indexPath.item])
        return cell
    }
    
    
}
