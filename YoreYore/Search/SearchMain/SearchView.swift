//
//  SearchView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit
import SnapKit
import Lottie
import Parchment

final class SearchView: BaseView {
    let mainScrollView = {
        let view = UIScrollView()
        view.maximumZoomScale = 1
        view.minimumZoomScale = 1
        return view
    }()
    let contentView = UIView()
    let topLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 25)
        view.textColor = Constants.Color.mainText
        view.numberOfLines = 0
        view.textAlignment = .right
        return view
    }()
    
    let cookingImageView = {
        let view: LottieAnimationView = .init(name: "bookLottie")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let textfieldView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.borderColor = Constants.Color.point?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let magnifyingImageView = {
        let view = UIImageView(frame: .zero)
        view.image = Constants.Image.magnifying
        view.tintColor = Constants.Color.secondPoint
        return view
    }()
    let searchTextField = {
        let view = UITextField()
        view.placeholder = SearchViewModel.Placeholder.successAppendTag.rawValue
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
        view.text = "재료가 담길때마다 검색됩니다!"
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
        vc.backgroundColor = Constants.Color.background
        vc.menuBackgroundColor = Constants.Color.background

//        vc.menu
        vc.menuItemSize = .selfSizing(estimatedWidth: 50, height: 50)
        vc.menuItemSpacing = 10
        vc.menuInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        vc.borderColor = UIColor(white: 0, alpha: 0.1)
        vc.selectedBackgroundColor = Constants.Color.background
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
        
        textfieldView.addViews([magnifyingImageView, searchTextField, xbutton])
        // tagList내부 그림 stackview
//        for imageView in ingredientsImageViews {
//            imageStackView.addArrangedSubview(imageView)
//        }
//        tagListCollectionView.addViews([imageStackView])
        contentView.addViews([topLabel, cookingImageView, textfieldView, messageLabel, tagListCollectionView, pagingViewController.view])
        mainScrollView.addSubview(contentView)
        addSubview(mainScrollView)
    }
    // MARK: - Layout
    override func configureConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(mainScrollView.snp.width)
            make.height.equalTo(700) // 임의로 줬는데 어케바꿈 ㅜㅜ
        }
        topLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
    
        }
        cookingImageView.snp.makeConstraints { make in
            make.bottom.equalTo(textfieldView.snp.top).offset(10)
            make.leading.equalTo(40)
            make.height.equalTo(100)
            make.width.equalTo(150)
            
        }
        textfieldView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(Constants.Layout.defaultPadding)
            make.height.equalTo(50)
        }
        magnifyingImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(22)
            make.centerY.equalToSuperview()
        }
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(magnifyingImageView.snp.trailing).offset(2)
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
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(18)
        }
        tagListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(Constants.Layout.defaultPadding)
            make.height.equalTo(1) // 원래 54
            print("SearchView에서 CollectionView의 높이: ", tagListCollectionView.contentSize.height)
        }
//        for item in ingredientsImageViews {
//            item.snp.makeConstraints { make in
//                make.size.equalTo(20)
//            }
//        }
//        imageStackView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
        
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(tagListCollectionView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    override func configureView() {
        // topLabel 글자 크기 다르게
        let topLabelText = "배달음식 말고\n집밥 어떠세요?"
        let attribtuedString = NSMutableAttributedString(string: topLabelText)
        let range = (topLabelText as NSString).range(of: "집밥 어떠세요?")
        attribtuedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 30), range: range)
        topLabel.attributedText = attribtuedString
        
        // 로티 애니메이션
        cookingImageView.loopMode = .loop // .repeat(3)
        cookingImageView.animationSpeed = 0.5
        cookingImageView.play()
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

