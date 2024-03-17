//
//  BookmarkViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/17.
//

import Foundation

final class BookmarkViewModel {
    let bookmarkRealm = BookmarkTableRepository.shared
    var inputselectedFoodType: Observable<Int?> = Observable(nil)
    
    var outputFetchFoodList: Observable<[FoodTable]> = Observable([])
    
    init() {
        bindData()
    }
    
    private func bindData() {
        inputselectedFoodType.bind { foodTypeIdx in
            // realm에서 가져오기
            self.updateFoodList(foodTypeIdx)
        }
    }
    
    func updateFoodList(_ foodTypeIdx: Int?) {
        guard let idx = foodTypeIdx else {
            print("foodTypeIdx nil")
            return
        }
        let foodList = self.bookmarkRealm.fetchItem(idx)
        self.outputFetchFoodList.value = foodList
    }
}
