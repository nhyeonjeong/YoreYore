//
//  BookmarkViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import UIKit

final class BookmarkViewController: BaseViewController {
    let mainView = BookmarkView()
    let viewModel = BookmarkViewModel()
    // Diffable사용
    private var dataSource: UICollectionViewDiffableDataSource<Int, Recipe>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        configureCollectionView()
        configureDataSource()
        updateSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 선택된 값이 이미 있는 상태면 collectionview 업데이트
        // viewWillAppear에서 한 번만 실행
        viewModel.isSelectedSegment()
    }
    
    private func bindData() {
        viewModel.outputFetchFoodList.bind { foodList in
            self.viewModel.isFoodListEmpty()
        }
        viewModel.outputcheckSelectedSegment.bind { isSelected in
            if isSelected {
                self.mainView.messageLabel.isHidden = true
            } else { // 선택된 값이 없는 상태면
                self.mainView.messageLabel.text = "북마크입니다\n음식종류를 선택해주세요!"
                self.mainView.messageLabel.isHidden = false
            }
        }
        viewModel.outputcheckEmptyFoodList.bind { isEmpty in
            if isEmpty {
                self.mainView.messageLabel.text = "북마크된 음식이 없습니다."
                self.mainView.messageLabel.isHidden = false
            } else {
                self.mainView.messageLabel.isHidden = true
            }
            self.updateSnapshot()
        }
    }
    override func configureView() {
        setNavigationBar()
        mainView.foodTypeSegment.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
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
//        print("viewModel.outputFetchList.value: \(viewModel.outputFetchFoodList.value)")
//        print("----------------------------")
        snapShot.appendItems(viewModel.outputFetchFoodList.value)
        dataSource.apply(snapShot)
//        dataSource.applySnapshotUsingReloadData(snapShot)
    }
}

extension BookmarkViewController: UICollectionViewDelegate {
    private func configureCollectionView() {
        mainView.bookmarkCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.inputSelectRecipeTrigger.value = indexPath.item
        
        let vc = RecipeDetailViewController()
//        vc.foodType = viewModel.selectedFoodType
        vc.food = viewModel.outputFetchFoodList.value[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}
