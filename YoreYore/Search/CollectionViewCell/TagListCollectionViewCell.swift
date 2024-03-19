//
//  TagListCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/18.
//

import UIKit
import SnapKit

final class TagListCollectionViewCell: BaseCollectionViewCell {
    let tagLabel = {
        let view = UILabel()
//        var config = UIButton.Configuration.filled()
//        config.cornerStyle = .capsule
//        config.baseBackgroundColor = Constants.Color.point
//        view.configuration = config
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = Constants.Color.point
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addViews([tagLabel])
    }
    override func configureConstraints() {
        tagLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(25)
        }
    }
    
    func upgradeCell(_ item: String) {
        tagLabel.text = "\(item) X"
    }
    
}
