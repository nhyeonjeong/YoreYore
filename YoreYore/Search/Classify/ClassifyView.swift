//
//  ClassifyView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit
import SnapKit

final class ClassifyView: BaseView {
    let failureMessage = {
        let view = UILabel()
        view.font = Constants.Font.manual
        view.textColor = Constants.Color.subText
        view.textAlignment = .center
        view.isHidden = true // 처음에는 hidden
        return view
    }()
    lazy var foodCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.backgroundColor = .clear
        return view
        
    }()
    
    override func configureHierarchy() {
        addViews([foodCollectionView, failureMessage])
    }
    
    override func configureConstraints() {
        foodCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        failureMessage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
extension ClassifyView {
    private func collectionViewLayout() -> UICollectionViewLayout {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group: NSCollectionLayoutGroup
        if #available(iOS 16.0, *) { // 16버전 이상에서
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            print("iOS 16.0이상")
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            print("iOS 15.0이하")
        }
        group.interItemSpacing = .fixed(4) // item간의 가로 간격
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4 // 그룹간 세로 간격
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)

    }
}

