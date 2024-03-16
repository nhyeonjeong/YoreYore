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
    // Diffable사용
    private var dataSource: UICollectionViewDiffableDataSource<Int, Recipe>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        configureDataSource()
        updateSnapshot()
    }
}

extension BookmarkViewController {
    func setNavigationBar() {
//        navigationItem.titleView = mainView.navigationTitleView
        navigationItem.title = "북마크"
    }
}

extension BookmarkViewController {
    private func configureDataSource() {
        let bookmarkCellRegistration = UICollectionView.CellRegistration<BookmarkCollectionViewCell, Recipe> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.bookmarkCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
        
            let cell = collectionView.dequeueConfiguredReusableCell(using: bookmarkCellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, Recipe>()
        snapShot.appendSections([0])
        snapShot.appendItems([])
        dataSource.apply(snapShot)
    }
}
