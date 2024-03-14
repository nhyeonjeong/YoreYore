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

    var food: Recipe!
    
    let mainView = RecipeDetailView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.food.value = food
//        bindData()
        configureCollectionView()
        configureDataSource() // snapshot찍기 전에 해야함(갱신전에 어떻게 표현해야할지가 먼저 있어야함)
        updateSnapshot()
    }
//    private func bindData() {
//        viewModel.outputSetManual.bind { _ in
//            print("다시그려")
//            self.updateSnapshot()
//        }
//    }
}

extension RecipeDetailViewController: UICollectionViewDelegate {
    
    func configureCollectionView() {
        mainView.manualCollectionView.delegate = self // Delegate를 위함
    }
    
    private func configureDataSource() {

        let detailCellRegistration = UICollectionView.CellRegistration<DetailCollectionViewCell, Recipe> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }
        
        let manualCellRegistration = UICollectionView.CellRegistration<ManualCollectionViewCell, Recipe.Manual> { cell, indexPath, ItemIdentifier in
            cell.upgradeCell(ItemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.manualCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let section = Section(rawValue: indexPath.section)
            switch section {
            case .detail:
                let cell = collectionView.dequeueConfiguredReusableCell(using: detailCellRegistration, for: indexPath, item: itemIdentifier as! Recipe)
                return cell
            case .manual:
                let cell = collectionView.dequeueConfiguredReusableCell(using: manualCellRegistration, for: indexPath, item: itemIdentifier as! Recipe.Manual)
                return cell
            case .none:
                let cell = collectionView.dequeueConfiguredReusableCell(using: manualCellRegistration, for: indexPath, item: itemIdentifier as! Recipe.Manual)
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


