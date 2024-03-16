//
//  BookmarkViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/17.
//

import Foundation

final class BookmarkViewModel {
    let bookmarkRealm = BookmarkTableRepository.shared
    var inputselectedFoodType: Observable<ClassifyList> = Observable(.dessert)
    
    var outputFetchFoodList: Observable<[FoodTable]> = Observable([])
    
    init() {
        bindData()
    }
    
    private func bindData() {
        inputselectedFoodType.bind { type in
            // realm에서 가져오기
            let foodList = self.bookmarkRealm.fetchItem(type)
            self.outputFetchFoodList.value = foodList
        }
    }
}
