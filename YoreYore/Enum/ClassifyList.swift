//
//  ClassifyList.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/12.
//

import Foundation

enum ClassifyList: Int, CaseIterable {
    case dessert // 후식
    case sideDish // 반찬
    case mainDish // 밥
//        case soup // 찌개또는 국
    
    var classifyName: String{
        switch self {
        case .dessert:
            return "후식"
        case .sideDish:
            return "반찬"
        case .mainDish:
            return "밥"
//        case .soup:
//            return "국&찌개"
        }
    }
}
