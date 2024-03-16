//
//  String+Extension.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/16.
//

import Foundation

extension String {
    func setHttps() -> String {
        if !self.hasPrefix("https") {
            return self.replacingOccurrences(of: "http", with: "https")
        }
        return self // 그대로 반환
    }
}
