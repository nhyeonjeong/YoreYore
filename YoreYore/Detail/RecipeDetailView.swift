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
        view.backgroundColor = .clear
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
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .white // 컴
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

         
        return layout
        
        /*
        // 여러 섹션을 다루려고 할 떄 provider매개변수 있는 거 사용
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            
            guard let section = RecipeDetailViewController.Section(rawValue: sectionIndex) else { return nil }
            
            
            let layoutSection: NSCollectionLayoutSection // NSCollectionLayoutSection을 하나 선언해야한다.
            switch section {
            case .detail:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                // absoulte는 절대적인,,사이즈 , 디바이스랑 상관없이 정해진다.
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 그룹안에 수평으으로 셀을 넣을지, 수직으로 넣을지(item과 group의 연결고리)
                
                // Section
                layoutSection = NSCollectionLayoutSection(group: group)
//                layoutSection.interGroupSpacing = 5 // 그룹간 세로 간격
                return layoutSection
                
            case .manual:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 그룹안에 수평으으로 셀을 넣을지, 수직으로 넣을지(item과 group의 연결고리)
                
                // Section
                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.interGroupSpacing = 5 // 그룹간 세로 간격
                
                return layoutSection
            }
             
        }
        
        return layout
         */
        
    }
}
