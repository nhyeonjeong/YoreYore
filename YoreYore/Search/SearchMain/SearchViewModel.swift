//
//  SearchViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/12.
//

import Foundation

final class SearchViewModel {
    var selectedFootType: ClassifyList = .dessert
//    var inputFetchRecipe: Observable<ClassifyList> = Observable(.dessert) // 레시피 통신하는 트리거
    var inputSearchBar: Observable<String> = Observable("") // 검색할 텍스트
    var recipeList: Observable<[Recipe]> = Observable([]) // api통신으로 가져온 레시피 결과
    
    init() {
        bindData()
    }
    
    private func bindData() {
        print("dfd")
        inputSearchBar.bind { searchText in
            // api통신
            RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .searchWithType(type: self.selectedFootType, search: searchText)) { data, error in
                
//                print("inputSearchBar api result = \(data)")
                
            }
        }
        /*
        inputFetchRecipe.bind { type in
            RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .foodType(type: type), completionHandler: { data, error in
//                print("inputFetchRecipe api result = \(data)")
                guard let data else {
                    print("api result data nil")
                    return
                }
                self.recipeList.value = data.COOKRCP01.row
            })
        }
         */
    }
}

