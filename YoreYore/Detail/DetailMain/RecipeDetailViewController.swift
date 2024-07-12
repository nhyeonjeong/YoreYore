//
//  RecipeDetailViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/11.
//

import UIKit

final class RecipeDetailViewController: BaseViewController {
    
    enum Section: Int, CaseIterable {
        case detail
        case manual
    }
//    var foodType: ClassifyList?
    var food: Recipe!
    let mainView = RecipeDetailView()
    let viewModel = RecipeDetailViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.foodType = viewModel.foodClassifyType(food.foodType)
        viewModel.food = food
        bindData()
        
        setNavigationTitle()
        configureCollectionView()
        configureDataSource()
        updateSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputFetchBookmarkTable.value = ()
    }
    
    private func bindData() {
        viewModel.bookmarkList.bind { _ in
            self.viewModel.inputCheckBookmarkTrigger.value = ()
        }
        viewModel.outputCheckBookmark.bind { isSaved in
            self.setNavigationBar(isSaved: isSaved) // 북마크버튼 다시 그리기
        }
    }
    
    @objc func bookmarkClicked() {
        viewModel.inputBookmarkTrigger.value = ()
    }
}

extension RecipeDetailViewController {
    private func setNavigationTitle() {
        navigationItem.title = food.foodName
    }
    private func setNavigationBar(isSaved: Bool) {
        // 북마크
        print("isSaved : ", isSaved)
        let buttomImage = isSaved ? Constants.Image.bookmarkFill : Constants.Image.bookmark
        let button = UIBarButtonItem(image: buttomImage, style: .plain, target: self, action: #selector(bookmarkClicked))
        button.tintColor = Constants.Color.secondPoint
        navigationItem.rightBarButtonItem = button
    }
}

extension RecipeDetailViewController: UICollectionViewDelegate {
    
    func configureCollectionView() {
        mainView.manualCollectionView.delegate = self // Delegate를 위함
    }
    
    private func configureDataSource() {
        let detailCellRegistration = UICollectionView.CellRegistration<DetailCollectionViewCell, Recipe> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }
        
        let manualCellRegistration = UICollectionView.CellRegistration<ManualCollectionViewCell, Row.Manual> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.manualCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let section = Section(rawValue: indexPath.section)
            switch section {
            case .detail:
                let cell = collectionView.dequeueConfiguredReusableCell(using: detailCellRegistration, for: indexPath, item: itemIdentifier as? Recipe)
                return cell
            case .manual:
                let cell = collectionView.dequeueConfiguredReusableCell(using: manualCellRegistration, for: indexPath, item: itemIdentifier as? Row.Manual)
                return cell
            case .none:
                let cell = collectionView.dequeueConfiguredReusableCell(using: manualCellRegistration, for: indexPath, item: itemIdentifier as? Row.Manual)
                return cell
            }
        })
    }
    
    private func updateSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems([food], toSection: .detail)
        snapShot.appendItems(food.manuals, toSection: .manual)
        dataSource.apply(snapShot)
    }
}


