//
//  FoodCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit
import SnapKit

final class FoodCollectionViewCell: BaseCollectionViewCell {
    private let foodImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let foodName: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.smallFont
        return view
    }()
    
    
    override func configureHierarchy() {
        contentView.addSubview(foodImage)
        contentView.addSubview(foodName)
        
    }
    
    override func configureConstraints() {
        foodImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(100)
        }
        foodName.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    func configureCell(recipe: Recipe) {
        foodName.text = recipe.foodName
        
    }
}
