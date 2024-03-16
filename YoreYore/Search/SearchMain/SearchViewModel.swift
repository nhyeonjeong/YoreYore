//
//  SearchViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/12.
//

import Foundation
import Parchment

final class SearchViewModel {
    let classifyCases = ClassifyList.allCases
    // 메뉴 배열
    let pagingItem: [PagingIndexItem] = {
        var list: [PagingIndexItem] = []
        ClassifyList.allCases.forEach { classify in
            list.append(PagingIndexItem(index: classify.rawValue, title: classify.classifyName))
        }
        return list
    }()
    
    var selectedFootType: ClassifyList = .dessert // 제일 처음은 dessert로 시작
    init() {
//        bindData()
    }
//    
//    private func bindData() {
//        print("dfd")
//        inputSearchBar.bind { searchText in
//            // api통신
//            RecipeAPIManager.shared.fetchRecipe(type: RCP.self, api: .searchWithType(type: self.selectedFootType, search: searchText)) { data, error in
//                
//                print("inputSearchBar api result = \(data)")
//                print("----------------------------------")
//                
//            }
//        }
//    }
}

