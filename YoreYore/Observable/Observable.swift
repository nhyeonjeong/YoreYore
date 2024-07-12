//
//  Observable.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

final class Observable<T> {
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
        self.closure = closure
    }
}

