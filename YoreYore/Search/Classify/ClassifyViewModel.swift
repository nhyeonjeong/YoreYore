//
//  ClassifyViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

final class ClassifyViewModel {
    struct SearchWithType {
        let foodType: ClassifyList
        let foodName: String
    }
    var recipeList: Observable<[Row]> = Observable([])
    var inputFetchRecipe: Observable<SearchWithType> = Observable(SearchWithType(foodType: .dessert, foodName: "")) // 레시피 통신하는 트리거
    
    init() {
        bindData()
    }
    private func bindData() {
        
        inputFetchRecipe.bind { search in
            // 만약 textfield에 아무것도 안적어놨으면 종류별로만 가져오기
            if search.foodName == "" {
                RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .foodType(type: search.foodType), completionHandler: { data, error in
                    guard let data else {
                        print("api result data nil")
                        return
                    }
                    self.recipeList.value = data.COOKRCP01.row
                })
            } else {
                
                RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .searchWithType(type: search.foodType, search: search.foodName), completionHandler: { data, error in
                    guard let data else {
                        print("api result data nil")
                        return
                    }
                    self.recipeList.value = data.COOKRCP01.row
                })
            }
        }
         
    }
}
