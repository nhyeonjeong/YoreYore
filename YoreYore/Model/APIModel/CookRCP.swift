//
//  CookRCP.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

struct RCP: Decodable {
    let COOKRCP01: CookRCP
}

struct CookRCP: Decodable {
    let row: [Recipe]
}
