//
//  Recipe.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

// CollectionView Diffable을 위한 새로운 구조체
struct Recipe: Hashable {
    var sequenceId: String
    var foodName: String
    var way: String
    var foodType: String
    var weight: String
    var kal: String
    var smallImage: String
    var largeImage: String // https가 아닐경우 가공해서 다시 저장하기 때문에 var로 변경
    var ingredients: String

    var manuals: [Row.Manual]
    var tip: String
}

  
