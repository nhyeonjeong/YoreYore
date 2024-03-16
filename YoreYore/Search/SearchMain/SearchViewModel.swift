//
//  SearchViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/12.
//

import Foundation
import Parchment

final class SearchViewModel {
    enum ClassifyList: Int, CaseIterable, PagingItem {
        func isBefore(item: Parchment.PagingItem) -> Bool {
            return true
        }
        
        case dessert // 후식
        case sideDish // 반찬
        case mainDish // 밥
    //        case soup // 찌개또는 국
        
        var classifyName: String{
            switch self {
            case .dessert:
                return "후식"
            case .sideDish:
                return "반찬"
            case .mainDish:
                return "밥"
    //        case .soup:
    //            return "국&찌개"
            }
        }
    }
    let classifyCases = ClassifyList.allCases
    // 메뉴 배열
    let pagingItem: [PagingIndexItem] = {
        var list: [PagingIndexItem] = []
        ClassifyList.allCases.forEach { classify in
            list.append(PagingIndexItem(index: classify.rawValue, title: classify.classifyName))
        }
        return list
    }()
    
    var selectedFootType: ClassifyList = .dessert
//    var inputSearchBar: Observable<String> = Observable("") // 검색할 텍스트
//    var recipeList: Observable<[Recipe]> = Observable([]) // api통신으로 가져온 레시피 결과
    
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

