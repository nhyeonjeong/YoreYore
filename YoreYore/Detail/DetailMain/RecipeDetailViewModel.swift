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
    var food: Row? = nil
    var bookmarkList: Observable<[BookmarkTable]> = Observable([])
    var foodListIdx: Int? = nil // bookmarkList에서 저장된 순서 인덱스
    
    var inputCheckBookmarkTrigger: Observable<Void?> = Observable(nil)
    var inputBookmarkTrigger: Observable<Void?> = Observable(nil)
    var inputFetchBookmarkTable: Observable<Void?> = Observable(nil)
    
    var outputCheckBookmark: Observable<Bool> = Observable(false) // checkBookmark 함수 실행할 때 저장
    
    init() {
        bindData()
    }
    
    func bindData() {
        inputFetchBookmarkTable.bind { _ in
            self.bookmarkList.value = self.bookmarkRealm.fetchItem() // BookmarkTable만 불러와서 foodList확인하면 됨
        }
        
        inputCheckBookmarkTrigger.bind { _ in
            self.checkBookmark() // 북마크여부 확인
        }
        inputBookmarkTrigger.bind { _ in
            guard let foodType = self.foodType, let food = self.food else {
                print("foodType = nil 이거나 Food = nil, 북마크에 저장할 수 없음")
                return
            }
            
            if self.outputCheckBookmark.value {
                // realm에서 삭제
                self.removeBookmark(foodType, food)
                print("realm에서 삭제해야함")
            } else {
                self.addBookmark(foodType, food)
            }
            self.outputCheckBookmark.value.toggle()
            self.inputFetchBookmarkTable.value = () // 북마크 리스트 다시 가져오기
        }
    }
    
    // 가져온 bookmarkList에 저장된 음식인지 확인해서 별도의 변수에 저장
    // 별도의 변수에 저장한 이유는? 이 음식이 북마크되어있는지 확인하고 싶을때마다
    // 변수 하나로 여부를 확인하는게 더 간단할 것 같았음.
    func checkBookmark() {
        guard let foodType, let food else {
            print("NO foodtype")
            return
        }
        let foodList = bookmarkList.value[foodType.rawValue].foodList
        for idx in 0..<foodList.count {
            if foodList[idx].sequenceId == food.sequenceId {
                outputCheckBookmark.value = true // 북마크여부 저장
                foodListIdx = idx
                return // 찾아면 바로 return
            }
        }
        outputCheckBookmark.value = false
    }
    
    func addBookmark(_ foodType: ClassifyList, _ food: Row) {
        var manualList: [ManualTable] = [] // 메뉴얼 리스트
        for i in 0..<food.manuals.count {
            let manualData = ManualTable(number: i+1, manualImageString: food.manuals[i].image, manualContent: food.manuals[i].content)
            manualList.append(manualData)
            
        }
        let foodTableData = FoodTable(sequenceId: food.sequenceId, foodType: food.foodType, foodName: food.foodName, way: food.way, mainImageString: food.largeImage, kcal: food.kal, ingredients: food.ingredients)
        
        self.foodRealm.createMenualItem(manualList: manualList, foodItem: foodTableData)
        self.bookmarkRealm.createFoodItem(foodTableData, foodTypeIdx: foodType.rawValue )
            print(self.foodRealm.realm.configuration.fileURL)
    }
    
    func removeBookmark(_ foodType: ClassifyList, _ food: Row) {
        guard let idx = foodListIdx else {
            print("foodListIdx = nil")
            return
        }
        let foodList = bookmarkList.value[foodType.rawValue].foodList
        foodRealm.removeItem(foodList[idx])
    }
}
