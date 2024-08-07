//
//  SearchViewController.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/08.
//

import UIKit
import Parchment

final class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    let viewModel = SearchViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        configurePaging()
        configureTextField()

        configureTagListCollectionView()
        configureDataSource()
        updateSnapshot()
    }

    private func bindData() {
        viewModel.outputTagList.bind { tagList in
            // tagList새로 그리기
            self.updateSnapshot()
            // contentSize.height = 0이면 1로 변경
            let newHeight: CGFloat = max(1, self.mainView.tagListCollectionView.contentSize.height)
            self.mainView.tagListCollectionView.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }
            self.mainView.pagingViewController.reloadData()
        }
        viewModel.outputPlaceholder.bind { placeholder in
            self.mainView.searchTextField.placeholder = placeholder
        }
    }
    
    @objc func xbuttonClicked() {
        mainView.searchTextField.text = ""
    }
    override func configureView() {
        navigationItem.title = "YoreYore"
        mainView.xbutton.addTarget(self, action: #selector(xbuttonClicked), for: .touchDown)
    }
}

extension SearchViewController {
    private func configureDataSource() {
        let tagListCellRegistration = UICollectionView.CellRegistration<TagListCollectionViewCell, String> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.tagListCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
        
            let cell = collectionView.dequeueConfiguredReusableCell(using: tagListCellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, String>()
        snapShot.appendSections([0])
        snapShot.appendItems(viewModel.outputTagList.value)
        dataSource.apply(snapShot)
    }
}
// MARK: - TagList CollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    private func configureTagListCollectionView() {
        mainView.tagListCollectionView.delegate = self
    }
    // 누르면 tagList에서 삭제
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        viewModel.outputTagList.value.remove(at: indexPath.item)
        print("tagList: \(viewModel.outputTagList.value)")
    }
    
    
}

// MARK: - PagingViewContorllerDatasource, PagingViewControllerDelegate
extension SearchViewController: PagingViewControllerDataSource, PagingViewControllerDelegate {
    // DateSource
    private func configurePaging() {
        mainView.pagingViewController.dataSource = self
        mainView.pagingViewController.delegate = self
    }
    // 1. 실행되는 순서
    func numberOfViewControllers(in pagingViewController: Parchment.PagingViewController) -> Int {
        return viewModel.classifyCases.count
    }
    // 3,
    func pagingViewController(_: Parchment.PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let classifyVC = ClassifyViewController(foodType: viewModel.classifyCases[index], searchIngredients: viewModel.outputTagList.value)
        
        classifyVC.scrollFunc = { cgPoint in
            self.mainView.mainScrollView.contentOffset.y = cgPoint.y
            let pointInSuperview = self.mainView.pagingViewController.view.frame.origin.y - self.mainView.mainScrollView.contentOffset.y
            self.mainView.contentView.snp.updateConstraints { make in
                make.height.equalTo(self.mainView.frame.height-pointInSuperview)
            }

        }
        // 상세화면으로 전환
        classifyVC.goDetailRcp = { recipe in
            let vc = RecipeDetailViewController()
            vc.food = recipe
//            vc.foodType = self.viewModel.selectedFoodType
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return classifyVC
    }
    // 2.
    func pagingViewController(_: Parchment.PagingViewController, pagingItemAt index: Int) -> Parchment.PagingItem {
        print(#function)
        return PagingIndexItem(index: index, title: viewModel.classifyCases[index].classifyName)
    }
    
    //Deleagate 당근
    // 메뉴 눌렸을 때 viewModel에 선택된 메뉴 저장
//    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
//        let menu = pagingItem as? PagingIndexItem
//        guard let index = menu?.index else {
//            print("selected menu index is nil")
//            return
//        }
//        viewModel.selectedFoodType = viewModel.classifyCases[index]
//        
//    }
}
// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    private func configureTextField() {
        mainView.searchTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text!
        if text == "" { // 검색창이 비어있으면 키보드 내리기
            view.endEditing(true)
        } else {
            viewModel.inputTextFieldReturn.value = text
            textField.text = ""
        }
        return true
    }
    
}

