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
    var bookmarkList: Observable<[BookmarkTable]> = Observable([])
    var inputBookmarkTrigger: Observable<Void?> = Observable(nil)
    var inputFetchFoodIdList: Observable<Void?> = Observable(nil)
    
    init() {
        bindData()
    }
    
    func bindData() {
        inputFetchFoodIdList.bind { _ in
            self.bookmarkList.value = self.bookmarkRealm.fetchItem() // BookmarkTable만 불러와서 foodList확인하면 됨
        }
        
        inputBookmarkTrigger.bind { _ in
            guard let foodType = self.foodType, let food = self.food else {
                print("foodType = nil 이거나 Food = nil, 북마크에 저장할 수 없음")
                return
            }
            
            var manualList: [ManualTable] = []
            for i in 0..<food.manuals.count {
                let manualData = ManualTable(number: i+1, manualImageString: food.manuals[i].image, manualContent: food.manuals[i].content)
                manualList.append(manualData)
                
            }
            let foodTableData = FoodTable(id: food.id, foodType: food.foodType, foodName: food.foodName, mainImageString: food.largeImage, kcal: food.kal, ingredients: food.ingredients)
            
            self.foodRealm.createMenualItem(manualList: manualList, foodItem: foodTableData)
            self.bookmarkRealm.createFoodItem(foodTableData, foodTypeIdx: foodType.rawValue )
//            print(self.foodRealm.realm.configuration.fileURL)
            print("dfdf")
        }
    }
    
    // 가져온 bookmarkList에 저장된 음식인지 확인
    func checkBookmark() -> Bool {
        guard let foodType, let food else {
            print("NO foodtype")
            return false
        }
//            for item in bookmarkList.value[foodType.rawValue].foodList {
//
//            }
        print("bookmarkList: \(bookmarkList.value)")
        let result = bookmarkList.value[foodType.rawValue].foodList.contains(where: { foodData in
            food.id == foodData.id
            
        })
        print(#function, result)
        return result
    }
}
