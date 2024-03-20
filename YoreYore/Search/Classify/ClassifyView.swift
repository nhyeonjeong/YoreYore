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
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
//        view.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
//        view.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
        view.backgroundColor = .clear
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
    private func collectionViewLayout() -> UICollectionViewLayout {
        /*
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 160) // 없으면 안됨
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        layout.scrollDirection = .vertical // 스크롤 방향도 FlowLayout에 속한다 -> contentMode때문에 Fill로
        return layout
        */
        // estimated하니까 글자에 맞춰서 ..!!!
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(4)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4 // 그룹간 세로 간격
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)

    }
}
