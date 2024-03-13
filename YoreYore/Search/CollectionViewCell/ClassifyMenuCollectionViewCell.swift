//
//  ClassifyCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit
import SnapKit

// 전혀 먹지 않고 있음,,,
final class ClassifyMenuCollectionViewCell: BaseCollectionViewCell {

    let classifyName: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.classifyBold
        view.textAlignment = .center
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(classifyName)
    }
    
    override func configureConstraints() {
        classifyName.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    override func configureView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.backgroundColor = .yellow
    }
    
}
