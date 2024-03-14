//
//  RecipeDetailView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/12.
//

import UIKit
import SnapKit
import Kingfisher

final class RecipeDetailView: BaseView {

    lazy var screenWidth = UIScreen.main.bounds.width
    
    lazy var manualCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

        return view
    }()
    
    override func configureHierarchy() {
        addSubview(manualCollectionView)
    }
    
    override func configureConstraints() {
        manualCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension RecipeDetailView {
    private func collectionViewLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        // absoulte는 절대적인,,사이즈 , 디바이스랑 상관없이 정해진다.
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(screenWidth), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 그룹안에 수평으으로 셀을 넣을지, 수직으로 넣을지(item과 group의 연결고리)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 50 // 그룹간 세로 간격
        return UICollectionViewCompositionalLayout(section: section)
        
    }
}
