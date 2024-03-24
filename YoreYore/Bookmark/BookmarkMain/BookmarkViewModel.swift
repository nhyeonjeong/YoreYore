//
//  BookmarkViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/17.
//

import Foundation

final class BookmarkViewModel {
    let bookmarkRealm = BookmarkTableRepository.shared
    let cases = ClassifyList.allCases.filter { classify in
        classify != .all
    }
    var inputselectedFoodType: Observable<ClassifyList?> = Observable(nil)
    var inputSelectRecipeTrigger: Observable<Int> = Observable(0)
    var outputFetchFoodList: Observable<[Recipe]> = Observable([])
    var outputcheckSelectedSegment: Observable<Bool> = Observable(false)
    var outputcheckEmptyFoodList: Observable<Bool> = Observable(false)
    
    init() {
        bindData()
    }
    
    private func bindData() {
        inputselectedFoodType.bind { foodType in
            // realm에서 가져오기
            print("iputselectedFoodType.bind", foodType?.classifyName)
            self.updateFoodList(foodType)
        }
    }
    
    // 화면진입시 segment가 선택된 상태인지
    func isSelectedSegment() {
        if let selectedIdx = inputselectedFoodType.value {
            updateFoodList(selectedIdx)
            outputcheckSelectedSegment.value = true
            // 선택된 상태라면 비었는지 확인해보기
            isFoodListEmpty()
        } else {
            outputcheckSelectedSegment.value = false
            inputselectedFoodType.value = .dessert // 디폴트는 디저트
        }
    }

    // 북마크 리스트가 비었는지?
    func isFoodListEmpty() {
        outputcheckEmptyFoodList.value = outputFetchFoodList.value.count == 0 ? true : false
    }
    // 북마크리스트 fetch
    private func updateFoodList(_ foodType: ClassifyList?) {
        guard let type = foodType else {
            print("foodTypeIdx nil")
            return
        }
        let foodList = self.bookmarkRealm.fetchItem(type)
        if foodList.isEmpty {
            self.outputFetchFoodList.value = []
            return
        }
        
        var recipeList: [Recipe] = []
        for data in foodList {
            var manualList: [Row.Manual] = []
            for data in data.manualList {
                let manual = Row.Manual(image: data.manualImageString, content: data.manualContent)
                manualList.append(manual)
            }
            let recipe = Recipe(sequenceId: data.sequenceId, foodName: data.foodName, way: data.way, foodType: data.foodType, weight: data.weight, kal: data.kcal, smallImage: "", largeImage: data.mainImageString, ingredients: data.ingredients, manuals: manualList, tip: data.tip)
            
            recipeList.append(recipe)
        }
        self.outputFetchFoodList.value = recipeList
    }
}
