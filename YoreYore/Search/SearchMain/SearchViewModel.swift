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
    let inputTextFieldReturn: Observable<String> = Observable("")
    let outputTagList: Observable<[String]> = Observable([])
    let outputPlaceholder: Observable<String> = Observable("")
    // 메뉴 배열
    let pagingItem: [PagingIndexItem] = {
        var list: [PagingIndexItem] = []
        ClassifyList.allCases.forEach { classify in
            list.append(PagingIndexItem(index: classify.rawValue, title: classify.classifyName))
        }
        return list
    }()
    
    var selectedFoodType: ClassifyList = .dessert // 제일 처음은 dessert로 시작
    
    init() {
        bindDate()
    }
    
    private func bindDate() {
        inputTextFieldReturn.bind { text in
            for tag in self.outputTagList.value {
                if tag == text {
                    self.outputPlaceholder.value = "같은 재료를 입력하셨습니다"
                    return
                }
            }
            self.outputTagList.value.append(text)
            self.outputPlaceholder.value = "재료를 검색해주세요"
        }
    }
}

