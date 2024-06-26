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
    
    func foodClassifyType(_ typeString: String) -> ClassifyList {
        let cases = ClassifyList.allCases
        if typeString == "국&찌개" { // api가 이상해서...
            return .soup
        }
        for i in 0..<cases.count {
            if cases[i].classifyName == typeString {
                return cases[i]
            }
        }
        return .dessert // 일단...
    }
    
    // 가져온 bookmarkList에 저장된 음식인지 확인해서 별도의 변수에 저장
    // 별도의 변수에 저장한 이유는? 이 음식이 북마크되어있는지 확인하고 싶을때마다
    // 변수 하나로 여부를 확인하는게 더 간단할 것 같았음.
    func checkBookmark() {
        guard let foodType, let food else {
            print("NO foodtype")
            return
        }
        for bookmark in bookmarkList.value {
            if bookmark.foodTypeRawValue == foodType.rawValue { // realm해당 음식종류가 생성되어있다면
                let foodList = bookmark.foodList
                for idx in 0..<foodList.count {
                    if foodList[idx].sequenceId == food.sequenceId {
                        outputCheckBookmark.value = true // 북마크여부 저장
                        return // 찾으면 바로 return
                    }
                }
                outputCheckBookmark.value = false // 못찾으면
                return
            }
        }
        // 위에서 realm에 대항 음식종류가 저장된 이력이 하나도 없다면
        outputCheckBookmark.value = false
        
    }
    
    func addBookmark(_ foodType: ClassifyList, _ food: Recipe) {
        var manualList: [ManualTable] = [] // 메뉴얼 리스트
        for i in 0..<food.manuals.count {
            let manualData = ManualTable(number: i+1, manualImageString: food.manuals[i].image, manualContent: food.manuals[i].content)
            manualList.append(manualData)
            
        }
        let foodTableData = FoodTable(sequenceId: food.sequenceId, foodType: food.foodType, foodName: food.foodName, way: food.way, mainImageString: food.largeImage, kcal: food.kal, ingredients: food.ingredients, tip: food.tip)
        
        self.foodRealm.createMenualItem(manualList: manualList, foodItem: foodTableData)
        
        // BookmarkTable에 해당 음식종류가 존재하는지 먼저 확인
        let data = bookmarkRealm.realm.objects(BookmarkTable.self)
        let bookData = data.filter { bookmark in
            bookmark.foodTypeRawValue == foodType.rawValue
        }
        if bookData.isEmpty {
            let bookmarkTableData = BookmarkTable(foodTypeRawValue: foodType.rawValue)
            bookmarkTableData.foodList.append(foodTableData)
            bookmarkRealm.createItem(bookmarkTableData) // 테이블 생성
        } else {
            self.bookmarkRealm.createFoodItem(foodTableData, bookmark: bookData[0])
        }
        
    }
    
    func removeBookmark(_ foodType: ClassifyList, _ food: Recipe) {
//        guard let idx = foodListIdx else {
//            print("foodListIdx = nil")
//            return
//        }
        let bookmarkTableData = bookmarkList.value.filter { bookmark in
            bookmark.foodTypeRawValue == foodType.rawValue
        }
        let foodList = Array(bookmarkTableData[0].foodList)
        let removeData = foodList.filter { foodTableData in
            foodTableData.sequenceId == food.sequenceId
        }
        foodRealm.removeItem(removeData[0])
    }
}
