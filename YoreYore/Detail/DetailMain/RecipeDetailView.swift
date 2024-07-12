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
    private enum Metric {
      static let headerHeight = 250.0
    }

    lazy var manualCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureHierarchy() {
        addViews([manualCollectionView])
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
        configuration.backgroundColor = .white
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
