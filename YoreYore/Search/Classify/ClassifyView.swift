//
//  ClassifyView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit
import SnapKit

final class ClassifyView: BaseView {

    lazy var foodCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        view.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
        view.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
        return view
        
    }()
    
    override func configureHierarchy() {
        addSubview(foodCollectionView)
    }
    
    override func configureConstraints() {
        foodCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

}
extension ClassifyView {
    private func collectionLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 160) // 없으면 안됨
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        layout.scrollDirection = .vertical // 스크롤 방향도 FlowLayout에 속한다 -> contentMode때문에 Fill로
        return layout
        
    }
}
