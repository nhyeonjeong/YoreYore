//
//  SearchViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/12.
//

import Foundation

final class SearchViewModel {
    var selectedFootType = ""
    var inputSearchBar: Observable<String> = Observable("")
    var recipeList: Observable<[Recipe]> = Observable([])
    
    init() {
        bindData()
    }
    
    private func bindData() {
        inputSearchBar.bind { searchText in
            // api통신
            RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .searchWithType(type: self.selectedFootType, search: searchText)) { data, error in
                
                print("inputSearchBar api result = \(data)")
                
            }
        }
    }
}

