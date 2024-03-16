//
//  BookmarkViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import UIKit

class BookmarkViewController: BaseViewController {
    let bookmarkRealm = BookmarkTableRepository.shared
    let mainView = BookmarkView()
    let viewModel = BookmarkViewModel()
    // Diffable사용
    private var dataSource: UICollectionViewDiffableDataSource<Int, FoodTable>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputselectedFoodType.value = .dessert // 일단 후식으로만
        bindData()
        setNavigationBar()
        
        configureDataSource()
        updateSnapshot()
    }
    
    private func bindData() {
        viewModel.outputFetchFoodList.bind { _ in
            self.updateSnapshot()
        }
    }
}

extension BookmarkViewController {
    private func setNavigationBar() {
//        navigationItem.titleView = mainView.navigationTitleView
        navigationItem.title = "북마크"
    }
}

extension BookmarkViewController {
    private func configureDataSource() {
        let bookmarkCellRegistration = UICollectionView.CellRegistration<BookmarkCollectionViewCell, FoodTable> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.bookmarkCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
        
            let cell = collectionView.dequeueConfiguredReusableCell(using: bookmarkCellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, FoodTable>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel.outputFetchFoodList.value)
        dataSource.apply(snapShot)
    }
}
