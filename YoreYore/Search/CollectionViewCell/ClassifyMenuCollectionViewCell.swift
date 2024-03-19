//
//  ClassifyCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit
import SnapKit
import Parchment

// 전혀 먹지 않고 있음,,,
final class ClassifyMenuCollectionViewCell: PagingCell {
    
    let menuBackImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFill
        return view
    }()
    let classifyNameLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.classifyBold
        view.textAlignment = .center
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    
    // 스토리보드로 할 때 실행되는 구문
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("no storyboard")
    }
    func configureHierarchy() {
        contentView.addSubview(menuBackImageView)
        menuBackImageView.addSubview(classifyNameLabel)
    }
    
    func configureConstraints() {
        menuBackImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.verticalEdges.equalToSuperview().inset(4)
        }
        classifyNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options _: PagingOptions) {
        let item = pagingItem as! SearchView.FoodMenuItem
        menuBackImageView.image = item.headerImage
        classifyNameLabel.text = item.classifyName
        if selected {
            menuBackImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        } else {
            menuBackImageView.transform = CGAffineTransform.identity
        }
    }
}
