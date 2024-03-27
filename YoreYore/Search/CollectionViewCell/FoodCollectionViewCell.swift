//
//  FoodCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit
import SnapKit
import Kingfisher

final class FoodCollectionViewCell: BaseCollectionViewCell {
    private let foodImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let foodNameLebel: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.smallFontBold
        view.textAlignment = .right
        view.numberOfLines = 0
        return view
    }()
    
    private let blurImageView = {
        let view = UIView()
        view.transform = .init(rotationAngle: 75)
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(foodImage)
        foodImage.addViews([blurImageView, foodNameLebel])
    }
    
    override func configureConstraints() {
        foodImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(100)
        }
        foodNameLebel.snp.makeConstraints { make in
            make.top.trailing.equalTo(foodImage).inset(10)
            make.width.equalTo(90)
        }
        
        blurImageView.snp.makeConstraints { make in
            make.centerY.equalTo(foodImage.snp.centerY)
            make.centerX.equalTo(foodImage.snp.trailing)
            make.size.equalTo(190)
        }
    }
    override func configureView() {
        contentView.clipsToBounds = true
        
        // UI꾸미기
//        let context = UIGraphicsRenderer()
        
    }
    
    func upgradeCell(_ recipe: Recipe) {
//        foodImage.kf.setImage(with: URL(string: recipe.largeImage))
        foodNameLebel.text = recipe.foodName
    }
}
