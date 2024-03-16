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
    @Persisted var foodTypeRawValue: Int
    @Persisted var foodList: List<FoodTable> // 저장한 레시피 리스트

    convenience init(foodTypeRawValue: Int) {
        self.init()
        self.foodTypeRawValue = foodTypeRawValue
    }
}

class FoodTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var foodType: String
    @Persisted var foodName: String
    @Persisted var mainImageString: String
    @Persisted var kcal: String
    @Persisted var ingredients: String
    @Persisted(originProperty: "foodList") var main: LinkingObjects<BookmarkTable>
    
    @Persisted var manualList: List<ManualTable>
    
    convenience init(foodType: String, foodName: String, mainImageString: String, kcal: String, ingredients: String) {
        self.init()
        self.foodType = foodType
        self.foodName = foodName
        self.mainImageString = mainImageString
        self.kcal = kcal
        self.ingredients = ingredients
    }
}

class ManualTable: Object {
    @Persisted var number: Int
    @Persisted var manualImageString: String
    @Persisted var manualContent: String
    @Persisted(originProperty: "manualList") var main: LinkingObjects<FoodTable>
    
    convenience init(number: Int, manualImageString: String, manualContent: String) { // convience랑 self.init()를 안해주면 오류가 나는 이유..?
        self.init()
        self.number = number
        self.manualImageString = manualImageString
        self.manualContent = manualContent
    }
}
