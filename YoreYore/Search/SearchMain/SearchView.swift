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
    private let classifyCases = ClassifyList.allCases
    
    let textfieldView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = Constants.Color.point?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let searchTextField = {
        let view = UITextField()
        view.placeholder = "재료를 검색해주세요"
        return view
    }()
    
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
    private let messageLabel = {
        let view = UILabel()
        view.text = "재료를 검색해서 담아주세요!"
        view.font = Constants.Font.smallFont
        view.textColor = Constants.Color.mainText
        return view
    }()
    let imageStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    // 디자인
    let ingredientsImageViews = {
        var views: [UIImageView] = []
        for item in Constants.Image.ingredients {
            let imageView = UIImageView(frame: .zero)
            imageView.image = item
            views.append(imageView)
        }
        return views
    }()
    // compositionalLayout
    lazy var tagListCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - pagingvc
    lazy var pagingViewController: PagingViewController = {
        let vc = PagingViewController()
        // 메뉴
        vc.register(ClassifyMenuCollectionViewCell.self, for: SearchViewModel.FoodMenuItem.self)
        vc.backgroundColor = Constants.Color.background ?? .background
        vc.menuBackgroundColor = Constants.Color.background ?? .background

//        vc.menu
        vc.menuItemSize = .selfSizing(estimatedWidth: 50, height: 50)
        vc.menuItemSpacing = 10
        vc.menuInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        vc.borderColor = UIColor(white: 0, alpha: 0.1)
        vc.selectedBackgroundColor = Constants.Color.background ?? .background
        vc.selectedTextColor = Constants.Color.point ?? .point
        vc.indicatorColor = Constants.Color.point ?? .point
        
        vc.indicatorOptions = .visible(
            height: 1,
            zIndex: Int.max,
            spacing: UIEdgeInsets.zero,
            insets: UIEdgeInsets.zero
        )

        vc.borderOptions = .visible(
            height: 2,
            zIndex: Int.max - 1,
            insets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        )
        return vc
    }()
   
    override func configureHierarchy() {
        textfieldView.addViews([searchTextField, xbutton])
        // tagList내부 그림 stackview
        for imageView in ingredientsImageViews {
            imageStackView.addArrangedSubview(imageView)
        }
        tagListCollectionView.addViews([imageStackView])
        self.addViews([textfieldView, messageLabel, tagListCollectionView, pagingViewController.view])
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
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(textfieldView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(Constants.Layout.defaultPadding)
            make.height.equalTo(18)
        }
        tagListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(Constants.Layout.defaultPadding)
            make.height.equalTo(54)// 높이 지정 안해줬다.
        }
        for item in ingredientsImageViews {
            item.snp.makeConstraints { make in
                make.size.equalTo(20)
            }
        }
        imageStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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

