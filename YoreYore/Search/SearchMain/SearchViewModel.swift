//
//  SearchViewModel.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/12.
//

import Foundation
import Parchment

final class SearchViewModel {
    enum Placeholder: String {
        case successAppendTag = "재료를 한글로 검색해주세요"
        case appendSameTag = "같은 재료를 입력하셨습니다"
    }
    // menu 구조체
    struct FoodMenuItem: PagingItem, Hashable {
        let index: Int
        let classifyName: String
        func isBefore(item: Parchment.PagingItem) -> Bool {
            return true
        }
    }
    let classifyCases = ClassifyList.allCases
    let inputTextFieldReturn: Observable<String> = Observable("")
    let outputTagList: Observable<[String]> = Observable([])
    let outputPlaceholder: Observable<String> = Observable("")
    
//    var selectedFoodType: ClassifyList = .dessert // 제일 처음은 dessert로 시작
    
    init() {
        bindDate()
    }
    
    private func bindDate() {
        inputTextFieldReturn.bind { text in
            for tag in self.outputTagList.value {
                if tag == text {
                    self.outputPlaceholder.value = Placeholder.appendSameTag.rawValue
                    return
                }
            }
            self.outputTagList.value.append(text)
            self.outputPlaceholder.value = Placeholder.successAppendTag.rawValue
        }
    }
}

