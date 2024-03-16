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
        view.image = .orangememo // 일단 핑크 메모로
        return view
    }()
    let foodTypeLabel = {
        let view = UILabel()
        view.font = Constants.Font.smallFont
        view.textColor = Constants.Color.mainText
        return view
    }()
    
    let foodNameLabel = {
        let view = UILabel()
        view.font = Constants.Font.classifyBold
        view.textColor = Constants.Color.mainText
        view.numberOfLines = 0
        return view
    }()
    
    let ingredientsLabel = {
        let view = UILabel()
        view.font = Constants.Font.smallFont
        view.textColor = Constants.Color.mainText
        view.numberOfLines = 0
        return view
    }()
    
    let foodImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
        
    }()
    
    override func configureHierarchy() {
        contentView.addViews([backImageView])
        backImageView.addViews([foodTypeLabel, foodNameLabel, ingredientsLabel, foodImageView])
    }
    
    override func configureConstraints() {
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        foodTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            
        }
    }
    func upgradeCell(_ item: Recipe) {
        foodTypeLabel.text = item.foodType
        foodNameLabel.text = item.foodName
        ingredientsLabel.text = item.ingredients
        guard let url = URL(string: item.largeImage) else {
            foodImageView.backgroundColor = .lightGray
            return
        }
        foodImageView.kf.setImage(with: url)
    }
    
}
