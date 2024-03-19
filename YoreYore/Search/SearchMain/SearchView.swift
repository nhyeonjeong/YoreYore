//
//  SearchView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit
import SnapKit
import Parchment

final class SearchView: BaseView {
    private struct FoodClassifyItem: PagingItem, Hashable {
        let classifyName: String
        func isBefore(item: Parchment.PagingItem) -> Bool {
            return true
        }
    }
    let textfieldView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = Constants.Color.point?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let searchTextField = UITextField()
    
    let xbutton = {
        let view = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = Constants.Image.searchXButton
        config.baseForegroundColor = Constants.Color.point
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.configuration = config
        view.tintColor = Constants.Color.background
        return view
    }()
    
    // compositionalLayout
    lazy var tagListCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.backgroundColor = .clear
        return view
    }()
    
    let pagingViewController: PagingViewController = {
        let vc = PagingViewController()
        // 메뉴 커스텀
        vc.register(ClassifyMenuCollectionViewCell.self, for: FoodClassifyItem.self)
        vc.backgroundColor = Constants.Color.point ?? .point
        vc.menuItemSize = .selfSizing(estimatedWidth: 40, height: 70)
        vc.menuItemSpacing = 10
//        vc.menuHorizontalAlignment = .center
        return vc
    }()
    
    override func configureHierarchy() {
        textfieldView.addViews([searchTextField, xbutton])
        self.addViews([textfieldView, tagListCollectionView, pagingViewController.view])
    }
    
    override func configureConstraints() {
        
        textfieldView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(Constants.Layout.defaultPadding)
            make.height.equalTo(50)
        }
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        xbutton.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
            make.trailing.equalToSuperview().inset(15)
        }
        
        tagListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(textfieldView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(Constants.Layout.defaultPadding)
            make.height.equalTo(100)// 높이 지정 안해줬다.
        }
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(tagListCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension SearchView {
    private func collectionViewLayout() -> UICollectionViewLayout {
        // estimated하니까 글자에 맞춰서 ..!!!
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(25))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(5)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4 // 그룹간 세로 간격
        return UICollectionViewCompositionalLayout(section: section)
    }
}

