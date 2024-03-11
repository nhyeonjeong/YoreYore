//
//  Observable.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

final class Observable<T> {
    // 내가 모르는 기능이 들어오도록
    private var closure: ((T) -> Void)?
    init(_ value: T) {
        self.value = value
    }
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        closure(value)
        self.closure = closure
    }
}

