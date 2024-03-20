//
//  ClassifyList.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/17.
//

import Foundation
import Parchment

enum ClassifyList: Int, CaseIterable, PagingItem {
    func isBefore(item: Parchment.PagingItem) -> Bool {
        return true
    }
    case all // 전체
    case dessert // 후식
    case sideDish // 반찬
    case mainDish // 밥
    case soup // 찌개또는 국
    
    var classifyName: String{
        switch self {
        case .all:
            return "전체"
        case .dessert:
            return "후식"
        case .sideDish:
            return "반찬"
        case .mainDish:
            return "밥"
        case .soup:
            return "국"
        }
    }
}
