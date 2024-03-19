//
//  TagListCollectionViewCell.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/18.
//

import UIKit
import SnapKit

final class TagListCollectionViewCell: BaseCollectionViewCell {
    let tagButton = {
        let view = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = Constants.Color.point
        view.configuration = config
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addViews([tagButton])
    }
    override func configureConstraints() {
        tagButton.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(25)
        }
    }
    
    func upgradeCell(_ item: String) {
        tagButton.setTitle("\(item) X", for: .normal)
    }
    
}
