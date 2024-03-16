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
    private var subDataStackView = UIStackView()
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
    
    private lazy var tipView = {
        let view = UIView()
//        view.setLineDot(color: Constants.Color.point, radius: 10)
        view.layer.borderColor = Constants.Color.point?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    private let tipIcon = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        view.image = Constants.Image.ingredients.randomElement()
        return view
    }()
    private let tipLable = {
        let view = UILabel()
        view.textColor = Constants.Color.mainText
        view.font = Constants.Font.smallFont
        view.numberOfLines = 0
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addViews([mainImageView, recipeNameLabel, subDataStackView, ingredientsLabel, tipView])
        subDataStackView.addViews([weightLabel, kalLabel])
        tipView.addViews([tipIcon, tipLable])
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
        subDataStackView.snp.makeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView).inset(horizontalInset)
            make.trailing.equalTo(contentView).inset(horizontalInset)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(subDataStackView)
            make.height.equalTo(20)
        }
        kalLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weightLabel)
            make.leading.equalTo(weightLabel.snp.trailing)
            make.trailing.equalTo(subDataStackView)
            make.height.equalTo(20)
        }
        tipIcon.snp.makeConstraints { make in
            make.top.equalTo(subDataStackView.snp.bottom).offset(12)
            make.size.equalTo(20)
            make.leading.equalTo(contentView).inset(horizontalInset)
        }
        tipView.snp.makeConstraints { make in
            make.top.equalTo(tipIcon.snp.top)
            make.leading.equalTo(tipIcon.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(horizontalInset)
            make.bottom.equalTo(contentView).inset(30) // 아래 간격
        }
        tipLable.snp.makeConstraints { make in
            make.edges.equalTo(tipView).inset(10)
        }
        
    }
    
//    override func configureView() {
//        tipView.setLineDot(color: Constants.Color.point, radius: 10)
//    }
    
    func upgradeCell(_ item: Recipe) {
        // cellForItemAt에 해당하는 메서드
        if let url = URL(string: item.largeImage) {
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
        tipLable.text = item.tip
    }
}
