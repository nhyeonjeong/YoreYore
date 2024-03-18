//
//  BookmarkView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import UIKit
import SnapKit

final class BookmarkView: BaseView {
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
        return view
    }()
    
    let foodTypeSegment: UISegmentedControl = {
        let view = UISegmentedControl()
        let cases = ClassifyList.allCases
        for idx in 0..<cases.count {
            view.insertSegment(withTitle: cases[idx].classifyName, at: idx, animated: true)
        }
        return view
    }()
    lazy var bookmarkCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
        view.backgroundColor = .clear
        return view
    }()
    
    let messageLabel = {
        let view = UILabel()
        view.font = Constants.Font.classify
        view.textColor = Constants.Color.point
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
//        navigationTitleView.addViews([titleViewImageView])
//        addViews([backImage])
        addViews([foodTypeSegment, bookmarkCollectionView])
        bookmarkCollectionView.addViews([messageLabel])
    }
    override func configureConstraints() {
//        titleViewImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        backImage.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(self)
//            make.bottom.equalTo(safeAreaLayoutGuide)
//        }
        foodTypeSegment.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        bookmarkCollectionView.snp.makeConstraints { make in
            make.top.equalTo(foodTypeSegment.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("no storyboard")
    }
}

extension BookmarkView {
    private func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        // absoulte는 절대적인,,사이즈 , 디바이스랑 상관없이 정해진다.
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 그룹안에 수평으으로 셀을 넣을지, 수직으로 넣을지(item과 group의 연결고리)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10 // 그룹간 세로 간격
        return UICollectionViewCompositionalLayout(section: section)
    }
}
