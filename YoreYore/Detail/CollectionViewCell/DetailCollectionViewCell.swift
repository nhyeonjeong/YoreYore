//
//  DetailCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/13.
//

import UIKit

final class DetailCollectionViewCell: BaseCollectionViewCell {
    private let horizontalInset: CGFloat = 10
    
    private let mainImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true // 이게 있어야 scaleAspectFill에 맞게 잘 나온다.
        return view
    }()
    
    private let recipeNameLabel = {
        let view = UILabel()
        view.textColor = Constants.Color.point
        view.font = Constants.Font.classifyBold
        return view
    }()
    
    private let weightLabel = {
        let view = UILabel()
        view.textColor = Constants.Color.subText
        view.font = Constants.Font.smallFont
        return view
    }()
    
    private let kalLabel = {
        let view = UILabel()
        view.font = Constants.Font.smallFont
        view.textColor = Constants.Color.subText
        return view
    }()
    
    private let ingredientsLabel = {
        let view = UILabel()
        view.font = Constants.Font.smallFont
        view.textColor = Constants.Color.mainText
        view.numberOfLines = 0
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addViews([mainImageView, recipeNameLabel, weightLabel, kalLabel, ingredientsLabel])
    }
    
    override func configureConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(230)
        }
        
        recipeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(horizontalInset)
            make.height.equalTo(22)
        }
        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeNameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(horizontalInset)
        }
        weightLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView).inset(horizontalInset)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView).inset(20) // 아래 간격
        }
        kalLabel.snp.makeConstraints { make in
            make.top.equalTo(weightLabel.snp.top)
            make.leading.equalTo(weightLabel.snp.trailing)
            make.height.equalTo(20)
            make.trailing.greaterThanOrEqualTo(contentView).inset(horizontalInset)
        }
    }
    
    func upgradeCell(_ item: Recipe) {
        let httpsString = item.largeImage.replacingOccurrences(of: "http", with: "https")
        // cellForItemAt에 해당하는 메서드
        if let url = URL(string: httpsString) {
            mainImageView.kf.setImage(with: url)
        } else {
            mainImageView.backgroundColor = .lightGray // 이미지가 없습니다...
            print("DetailCollectionVIewCell no image-----------")
        }
        recipeNameLabel.text = item.foodName
        ingredientsLabel.text = item.ingredients
        if item.weight == "" {
            weightLabel.isHidden = true // 빈 문자열이면 아예 숨기기
        } else {
            weightLabel.text = "중량 : \(item.weight)g "
        }
        kalLabel.text = "\(item.kal)kcal"
        
    }
}
