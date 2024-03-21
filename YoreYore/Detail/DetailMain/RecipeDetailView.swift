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
//    private let mainImageView = {
//        let view = UIImageView(frame: .zero)
//        view.contentMode = .scaleAspectFill
//        view.clipsToBounds = true // 이게 있어야 scaleAspectFill에 맞게 잘 나온다.
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    lazy var manualCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.backgroundColor = .clear
//        view.showsVerticalScrollIndicator = false
//        view.translatesAutoresizingMaskIntoConstraints = false
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
        configuration.backgroundColor = .white // 컴
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
