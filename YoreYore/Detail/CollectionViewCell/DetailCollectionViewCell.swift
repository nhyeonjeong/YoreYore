//
//  DetailCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/13.
//

import UIKit

final class DetailCollectionViewCell: BaseCollectionViewCell {
    private let mainImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true // 이게 있어야 scaleAspectFill에 맞게 잘 나온다.
        return view
    }()
    
    private let recipeNameLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(recipeNameLabel)
    }
    
    override func configureConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(180)
        }
        
        recipeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
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
    }
    
    
}
