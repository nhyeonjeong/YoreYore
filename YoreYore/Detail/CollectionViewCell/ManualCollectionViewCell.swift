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
    let manualImageView = UIImageView(frame: .zero)
    let manualLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(manualImageView)
        contentView.addSubview(manualLabel)
    }
    
    override func configureConstraints() {
        manualImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(180)
            
        }
        manualLabel.snp.makeConstraints { make in
            make.top.equalTo(manualImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        manualImageView.contentMode = .scaleAspectFill
    }
    
    func upgradeCell(_ manual: Recipe.Manual) {
        let httpsImageString = manual.image.replacingOccurrences(of: "http", with: "https")
        if let url = URL(string: httpsImageString) {
            manualImageView.kf.setImage(with: url)
        } else {
            manualImageView.backgroundColor = .lightGray
        }
        manualLabel.text = manual.content
    }
}
