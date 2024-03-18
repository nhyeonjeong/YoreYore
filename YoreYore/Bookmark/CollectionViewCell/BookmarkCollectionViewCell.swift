//
//  BookmarkCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import UIKit
import SnapKit
import Kingfisher

class BookmarkCollectionViewCell: BaseCollectionViewCell {
    let backImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.image = .checkmemo // 일단 핑크 메모로
        return view
    }()
    
    let foodNameLabel = {
        let view = UILabel()
        view.font = Constants.Font.classifyBold
        view.textColor = Constants.Color.mainText
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    let foodImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
        
    }()
    
    let ingredientsLabel = {
        let view = UILabel()
        view.font = Constants.Font.smallFont
        view.textColor = Constants.Color.mainText
        view.numberOfLines = 5
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addViews([backImageView])
        backImageView.addViews([foodNameLabel, ingredientsLabel, foodImageView])
    }
    
    override func configureConstraints() {
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        foodNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(22)
        }
        
        foodImageView.snp.makeConstraints { make in
            make.top.equalTo(foodNameLabel.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(150)
        }
        
        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(10)
            
        }

    }
    func upgradeCell(_ item: Recipe) {
//        foodTypeLabel.text = "\(item.foodType) | "
        foodNameLabel.text = item.foodName
        ingredientsLabel.text = item.ingredients
        guard let url = URL(string: item.largeImage) else {
            foodImageView.backgroundColor = .lightGray
            return
        }
        foodImageView.kf.setImage(with: url)
    }
    
}
