//
//  RealmRecipe.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import Foundation
import RealmSwift

class BookmarkTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var foodType: String
    @Persisted var bookmarkList: List<BookmarkTable> // 저장한 레시피 리스트

    convenience init(foodType: String) {
        self.init()
        self.foodType = foodType
    }
}

class FoodTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var foodType: String
    @Persisted var foodName: String
    @Persisted var kcal: String
    @Persisted var ingredients: String
    @Persisted var manual: List<MenualTable>
}

class MenualTable: Object {
    @Persisted(primaryKey: true) var number: Int
    @Persisted var manualImageString: String
    @Persisted var manualContent: String
}
