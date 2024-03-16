//
//  BookmarkView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import UIKit
import SnapKit

class BookmarkView: BaseView {
    /*
    let navigationTitleView = UIView()
    let titleViewImageView = {
        let view = UIImageView(frame: .zero)
        view.animationImages = {
            var list: [UIImage] = []
            for i in 0..<3 {
                list.append(Constants.Image.forkFill)
            }
            return list
        }()
        
        view.image?.withTintColor(Constants.Color.point ?? .point)
        view.contentMode = .scaleToFill
        return view
    }()
     */
    
    let backImage = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.image = Constants.Image.bookmarkBack
        view.layer.opacity = 0.4
        return view
    }()
    
    lazy var bookmarkCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
//        navigationTitleView.addViews([titleViewImageView])
        addViews([backImage])
        backImage.addViews([bookmarkCollectionView])
    }
    override func configureConstraints() {
//        titleViewImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        backImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        bookmarkCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("no storyboard")
    }
}

extension BookmarkView {
    func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        // absoulte는 절대적인,,사이즈 , 디바이스랑 상관없이 정해진다.
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 그룹안에 수평으으로 셀을 넣을지, 수직으로 넣을지(item과 group의 연결고리)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5 // 그룹간 세로 간격
        return UICollectionViewCompositionalLayout(section: section)
    }
}
