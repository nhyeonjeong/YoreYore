//
//  RecipeDetailViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/17.
//

import Foundation

final class RecipeDetailViewModel {
    let bookmarkRealm = BookmarkTableRepository.shared
    let foodRealm = FoodTableRepository.shared
    let manualRealm = ManualRepository.shared
    
    var foodType: ClassifyList? = nil
    var food: Recipe? = nil
    var inputCheckBookmark: Observable<Void?> = Observable(nil)
    
    init() {
        bindData()
    }
    
    func bindData() {
        inputCheckBookmark.bind { _ in
            guard let foodType = self.foodType, let food = self.food else {
                print("foodType = nil 이거나 Food = nil, 북마크에 저장할 수 없음")
                return
            }
            
            var manualList: [ManualTable] = []
            for i in 0..<food.manuals.count {
                let manualData = ManualTable(number: i+1, manualImageString: food.manuals[i].image, manualContent: food.manuals[i].content)
                manualList.append(manualData)
                
            }
            let foodTableData = FoodTable(foodType: food.foodType, foodName: food.foodName, kcal: food.kal, ingredients: food.ingredients)
            
            self.foodRealm.createMenualItem(manualList: manualList, foodItem: foodTableData)
            self.bookmarkRealm.createFoodItem(foodTableData, foodTypeIdx: foodType.rawValue )
        }
        
    }
}
