//
//  ClassifyViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

final class ClassifyViewModel {
    struct SearchWithIngredients {
        let foodType: ClassifyList
        let ingredients: [String]
    }
    var recipeList: Observable<[Recipe]> = Observable([])
    var inputFetchRecipe: Observable<SearchWithIngredients> = Observable(SearchWithIngredients(foodType: .dessert, ingredients: [])) // 레시피 통신하는 트리거
    var outputFailureMessage = Observable<String?>(nil)
    let fetchUnit: Int = 25
    var fetchStartIdx: Int = 0
    var fetchEndIdx: Int = 24
    var totalRecipeCount: Int = 0 // 전체 검색한 결과 레시피 숫자

    init() {
        bindData()
    }
    private func bindData() {
        inputFetchRecipe.bind { search in
            // 만약 tagList가 비어있다면 종류별로만 가져오기
            // tagList에 내용이 있다면 종류&재료로 api통신
//            self.recipeList.value = []
            
            if search.ingredients.count == 0 {
                print("태그리스트 없음!!", search.foodType)
                RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .foodType(type: search.foodType, startIdx: self.fetchStartIdx, endIdx: self.fetchEndIdx), completionHandler: { response in
                    switch response {
                    case .success(let success):
                        guard let data = success else {
                            print("api success response data nil")
                            return
                        }
                        let fetchData = data.COOKRCP01.row
                        guard let count = Int(data.COOKRCP01.total_count) else {
                            print("totalCount is not Int")
                            return
                        }
                        self.totalRecipeCount = count
                        
                        var temtRecipeList: [Recipe] = []
                        for data in fetchData {
                            let recipe = Recipe(sequenceId: data.sequenceId, foodName: data.foodName, way: data.way, foodType: data.foodType, weight: data.weight, kal: data.kal, smallImage: data.smallImage, largeImage: data.largeImage, ingredients: data.ingredients, manuals: data.manuals, tip: data.tip)
                            temtRecipeList.append(recipe)
                        }
                        self.outputFailureMessage.value = nil
                        self.recipeList.value.append(contentsOf: temtRecipeList)
                    case .failure(let failure):
                        switch failure {
                        case .noData:
                            self.outputFailureMessage.value = "검색결과가 없습니다"
                        default:
                            self.outputFailureMessage.value = "오류가 발생했습니다."
                        }
                    }
                })
            } else {
                print("태그리스트 있음!!")
                RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .searchWithIngredients(type: search.foodType, ingredients: search.ingredients, startIdx: self.fetchStartIdx, endIdx: self.fetchEndIdx), completionHandler: { response in
                    
                    switch response {
                    case .success(let success):
                        guard let data = success else {
                            print("api result data nil")
                            return
                        }
                        let fetchData = data.COOKRCP01.row
                        guard let count = Int(data.COOKRCP01.total_count) else {
                            print("totalCount is not Int")
                            return
                        }
                        self.totalRecipeCount = count
                        var temtRecipeList: [Recipe] = []
                        for data in fetchData {
                            let recipe = Recipe(sequenceId: data.sequenceId, foodName: data.foodName, way: data.way, foodType: data.foodType, weight: data.weight, kal: data.kal, smallImage: data.smallImage, largeImage: data.largeImage, ingredients: data.ingredients, manuals: data.manuals, tip: data.tip)
                            temtRecipeList.append(recipe)
                        }
                        self.outputFailureMessage.value = nil
                        self.recipeList.value.append(contentsOf: temtRecipeList)
                    case .failure(let failure):
                        switch failure {
                        case .noData:
                            self.outputFailureMessage.value = "검색결과가 없습니다"
                        default:
                            self.outputFailureMessage.value = "오류가 발생했습니다."
                        }
                    }
                })
            }
        }
    }
    // startIdx, endIdx 지정 후 api 통신
    func setApiIndex() {
        fetchStartIdx += fetchUnit
        // endIdx가 viewMdodel.totalRecipeCount을 초과하지는 않는지
        let newFetchEndIdx = fetchEndIdx + fetchUnit
        fetchEndIdx = newFetchEndIdx < totalRecipeCount ? newFetchEndIdx : totalRecipeCount
    }
}
