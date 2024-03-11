//
//  FoodCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit
import SnapKit

final class FoodCollectionViewCell: BaseCollectionViewCell {
    private let testLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(testLabel)
        
    }
    
    override func configureConstraints() {
        testLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    func configureCell(recipe: Recipe) {
        testLabel.text = recipe.foodName
        
    }
}
