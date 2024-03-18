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
    var inputSelectRecipeTrigger: Observable<Int> = Observable(0)
    var outputcheckSelectedSegment: Observable<Bool> = Observable(false)
    var outputcheckEmptyFoodList: Observable<Bool> = Observable(false)
    // CollectionView셀을 선택했을 때 갱신
    var selectedFoodType: ClassifyList = .dessert
    var selectedRecipe: Recipe?
    
    init() {
        bindData()
    }
    
    private func bindData() {
        inputselectedFoodType.bind { foodTypeIdx in
            // realm에서 가져오기
            self.updateFoodList(foodTypeIdx)
        }
        
        inputSelectRecipeTrigger.bind { selectedIdx in
            self.selectedFoodType = self.getFoodType()

        }
    }
    // 북마크리스트 fetch
    func updateFoodList(_ foodTypeIdx: Int?) {
        guard let idx = foodTypeIdx else {
            print("foodTypeIdx nil")
            return
        }
        let foodList = self.bookmarkRealm.fetchItem(idx)
        self.outputFetchFoodList.value = foodList
    }
    /// 음식종류 idx를 ClassifyList타입으로 변환
    func getFoodType() -> ClassifyList {
        guard let foodTypeIdx = inputselectedFoodType.value else {
            print("inputselectedFoodType.value is nil")
            return .dessert // 디폴트로 dessert
        }
        return ClassifyList.allCases[foodTypeIdx]
    }
    
    // 화면진입시 segment가 선택된 상태인지
    func isSelectedSegment() {
        if let selectedIdx = inputselectedFoodType.value {
            updateFoodList(selectedIdx)
            outputcheckSelectedSegment.value = true
            // 선택된 상태라면 비었는지 확인해보기
            isFoodListEmpty()
        } else {
            outputcheckSelectedSegment.value = false
        }
    }

    // 북마크 리스트가 비었는지?
    func isFoodListEmpty() {
        outputcheckEmptyFoodList.value = outputFetchFoodList.value.count == 0 ? true : false
    }
}
