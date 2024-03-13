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
//        case manual
    }
    var food: Recipe!
    lazy var manualList: [String] = {
        var list: [String] = []
        for i in 0..<14 {
            list.append(food.manual_01)
        }
        return list
    }()
    
    lazy var manualImageList: [String] = {
        var list: [String] = []
        for i in 0..<14 {
            list.append(food.manualImage_01)
        }
        return list
    }()
    let mainView = RecipeDetailView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!
    //    private var manualDataSource: UICollectionViewDiffableDataSource<Section, Recip
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource() // snapshot찍기 전에 해야함(갱신전에 어떻게 표현해야할지가 먼저 있어야함)
        updateSnapshot()
    }
}

extension RecipeDetailViewController: UICollectionViewDelegate {
    
    func configureCollectionView() {
        mainView.manualCollectionView.delegate = self // Delegate를 위함
    }
    
    private func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<DetailCollectionViewCell, Recipe> { cell, indexPath, ItemIdentifier in
            let httpsString = ItemIdentifier.largeImage.replacingOccurrences(of: "http", with: "https")
            // cellForItemAt에 해당하는 메서드
            if let url = URL(string: httpsString) {
                cell.mainImageView.kf.setImage(with: url)
            } else {
                cell.mainImageView.backgroundColor = .lightGray // 이미지가 없습니다...
                print("DetailCollectionVIewCell no image-----------")
            }
            print(ItemIdentifier)
            cell.recipeNameLabel.text = ItemIdentifier.foodName
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.manualCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([food])
        dataSource.apply(snapshot)
    }
    
}


