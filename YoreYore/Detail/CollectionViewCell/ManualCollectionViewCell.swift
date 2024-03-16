//
//  RecipeDetailCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/13.
//

import UIKit
import SnapKit
import Kingfisher

class ManualCollectionViewCell: BaseCollectionViewCell {
    private let manualImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.Color.point?.cgColor
        return view
    }()
    
    private let manualLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = Constants.Font.manual
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(manualImageView)
        contentView.addSubview(manualLabel)
    }
    
    override func configureConstraints() {
        manualImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(Constants.Layout.detailCollectionPadding)
            make.height.equalTo(180)
            
        }
        manualLabel.snp.makeConstraints { make in
            make.top.equalTo(manualImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(Constants.Layout.detailCollectionPadding)
            make.bottom.equalTo(contentView).inset(30)
        }
    }
    
    func upgradeCell(_ manual: Recipe.Manual) {
        if let url = URL(string: manual.image) {
            manualImageView.kf.setImage(with: url)
        } else {
            manualImageView.backgroundColor = .lightGray
        }
        manualLabel.text = manual.content
    }
}
