//
//  Constants.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit

enum Constants {
    enum Color {
        static let background = UIColor.white
        static let mainText = UIColor.black
        static let subText = UIColor.systemGray2
        static let point = UIColor(named: "pointColor")
        static let secondPoint = UIColor.orange
    }
    
    enum Font {
        static let titleName = UIFont.boldSystemFont(ofSize: 16)
        static let classifyBold = UIFont.boldSystemFont(ofSize: 15)
        static let classify = UIFont.systemFont(ofSize: 15)
        static let manual = UIFont.systemFont(ofSize: 14)
        static let smallFont = UIFont.systemFont(ofSize: 13)
        static let smallFontBold = UIFont.boldSystemFont(ofSize: 13)
    }
    
    enum Image {
        static let bookmarkBack: UIImage = .bookmarkBack
        static let searchXButton = UIImage(systemName: "xmark.circle.fill")
        static let magnifying = UIImage(systemName: "magnifyingglass")
        static let bookmarkFill: UIImage = .bookmarkFill
        static let bookmark: UIImage = .bookmark
        static let bowl: UIImage = .bowl
        static let forkFill: UIImage = .fork
        static let ingredients: [UIImage] = [.avocado, .broccoli, .cherry, .egg, .icecream, .tomato]
        
    }
    
    enum Layout {
        static let detailCollectionPadding: CGFloat = 40
        static let defaultPadding: CGFloat = 15
    }
}
