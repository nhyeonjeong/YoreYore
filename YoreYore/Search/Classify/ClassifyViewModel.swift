//
//  ClassifyViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

final class ClassifyViewModel {
    var recipeList: Observable<[Recipe]> = Observable([])
    var inputFetchRecipe: Observable<ClassifyList> = Observable(.dessert) // 레시피 통신하는 트리거
    
    init() {
        bindData()
    }
    private func bindData() {
        
        inputFetchRecipe.bind { type in
            RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .foodType(type: type), completionHandler: { data, error in
                print("inputFetchRecipe api result = \(data)")
                guard let data else {
                    print("api result data nil")
                    return
                }
                self.recipeList.value = data.COOKRCP01.row
            })
        }
         
    }
}
