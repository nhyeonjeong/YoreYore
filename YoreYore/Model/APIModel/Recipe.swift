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
    var largeImage: String
    var ingredients: String

    var manuals: [Row.Manual]
    var tip: String
}

  
