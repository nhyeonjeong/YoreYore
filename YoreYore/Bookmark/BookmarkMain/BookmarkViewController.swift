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
        bindData()
        setNavigationBar()
        super.viewDidLoad()
        mainView.foodTypeSegment.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
        configureDataSource()
        updateSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 선택된 값이 이미 있는 상태면 collectionview 업데이트
        if let selectedIdx = viewModel.inputselectedFoodType.value {
            viewModel.updateFoodList(selectedIdx)
            mainView.messageLabel.isHidden = true
            checkFoodListEmpty()
        } else { // 선택된 값이 없는 상태면
            mainView.messageLabel.text = "북마크입니다\n음식종류를 선택해주세요!"
            mainView.messageLabel.isHidden = false
        }
    }
    
    private func bindData() {
        viewModel.outputFetchFoodList.bind { foodList in
            self.checkFoodListEmpty()
        }
    }
    
    func checkFoodListEmpty() {
        if viewModel.outputFetchFoodList.value.count == 0 {
            self.mainView.messageLabel.text = "북마크된 음식이 없습니다."
            self.mainView.messageLabel.isHidden = false
        } else {
            self.mainView.messageLabel.isHidden = true
        }
        self.updateSnapshot()
    }
    @objc func segmentClicked() {
        print(#function)
        let selectedIdx = mainView.foodTypeSegment.selectedSegmentIndex
        print("selectedIdx: \(selectedIdx)")
        viewModel.inputselectedFoodType.value = selectedIdx
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
//        print("viewModel.outputFetchList.value: \(viewModel.outputFetchFoodList.value)")
//        print("----------------------------")
        snapShot.appendItems(viewModel.outputFetchFoodList.value)
//        dataSource.apply(snapShot)
        dataSource.applySnapshotUsingReloadData(snapShot)
    }
}
