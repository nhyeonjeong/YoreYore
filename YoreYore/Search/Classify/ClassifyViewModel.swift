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
    var recipeList: Observable<[Recipe]> = Observable([])
    var inputFetchRecipe: Observable<SearchWithType> = Observable(SearchWithType(foodType: .dessert, foodName: "")) // 레시피 통신하는 트리거
    
    init() {
        bindData()
    }
    private func bindData() {
        inputFetchRecipe.bind { search in
            // 만약 textfield에 아무것도 안적어놨으면 종류별로만 가져오기
            // textfield에 내용이 있다면 종류&이름으로 api통신
            self.recipeList.value = []
            
            if search.foodName == "" {
                RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .foodType(type: search.foodType), completionHandler: { data, error in
                    guard let data else {
                        print("api result data nil")
                        return
                    }
                    let fetchData = data.COOKRCP01.row
                    var recipeList: [Recipe] = []
                    for data in fetchData {
                        let recipe = Recipe(sequenceId: data.sequenceId, foodName: data.foodName, way: data.way, foodType: data.foodType, weight: data.weight, kal: data.kal, smallImage: data.smallImage, largeImage: data.largeImage, ingredients: data.ingredients, manuals: data.manuals, tip: data.tip)
                        recipeList.append(recipe)
                    }
                    self.recipeList.value = recipeList
                })
            } else {
                
                RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .searchWithType(type: search.foodType, search: search.foodName), completionHandler: { data, error in
                    guard let data else {
                        print("api result data nil")
                        return
                    }
                    let fetchData = data.COOKRCP01.row
                    for data in fetchData {
                        let recipe = Recipe(sequenceId: data.sequenceId, foodName: data.foodName, way: data.way, foodType: data.foodType, weight: data.weight, kal: data.kal, smallImage: data.smallImage, largeImage: data.largeImage, ingredients: data.ingredients, manuals: data.manuals, tip: data.tip)
                        self.recipeList.value.append(recipe)
                    }
                })
            }
        }
         
    }
}
