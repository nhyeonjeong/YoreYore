//
//  Recipe.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

struct Recipe: Decodable, Hashable {

    let id: String
    let foodName: String
    let way: String
    let footType: String
    let weight: String
    let kal: String
    let smallImage: String
    let largeImage: String
    let ingredients: String
    let manualImage_01: String
    let manual_01: String
    let manualImage_02: String
    let manual_02: String
    let manualImage_03: String
    let manual_03: String
    let manualImage_04: String
    let manual_04: String
    let manualImage_05: String
    let manual_05: String
    let manualImage_06: String
    let manual_06: String
    let manualImage_07: String
    let manual_07: String
    let manualImage_08: String
    let manual_08: String
    let manualImage_09: String
    let manual_09: String
    let manualImage_10: String
    let manual_10: String
    let manualImage_11: String
    let manual_11: String
    let manualImage_12: String
    let manual_12: String
    let manualImage_13: String
    let manual_13: String
    let manualImage_14: String
    let manual_14: String
    let manualImage_15: String
    let manual_15: String
    let manualImage_16: String
    let manual_16: String
    let manualImage_17: String
    let manual_17: String
    let manualImage_18: String
    let manual_18: String
    let manualImage_19: String
    let manual_19: String
    let manualImage_20: String
    let manual_20: String
    let tip: String
 
    enum CodingKeys: String, CodingKey {
        case id = "RCP_SEQ"
        case foodName = "RCP_NM"
        case way = "RCP_WAY2"
        case footType = "RCP_PAT2"
        case weight = "INFO_WGT" // "" 일수도 있음 주의
        case kal = "INFO_ENG"
        case smallImage = "ATT_FILE_NO_MAIN"
        case largeImage = "ATT_FILE_NO_MK"
        case ingredients = "RCP_PARTS_DTLS"
        case manualImage_01 = "MANUAL_IMG01"
        case manual_01 = "MANUAL01"
        case manualImage_02 = "MANUAL_IMG02"
        case manual_02 = "MANUAL02"
        case manualImage_03 = "MANUAL_IMG03"
        case manual_03 = "MANUAL03"
        case manualImage_04 = "MANUAL_IMG04"
        case manual_04 = "MANUAL04"
        case manualImage_05 = "MANUAL_IMG05"
        case manual_05 = "MANUAL05"
        case manualImage_06 = "MANUAL_IMG06"
        case manual_06 = "MANUAL06"
        case manualImage_07 = "MANUAL_IMG07"
        case manual_07 = "MANUAL07"
        case manualImage_08 = "MANUAL_IMG08"
        case manual_08 = "MANUAL08"
        case manualImage_09 = "MANUAL_IMG09"
        case manual_09 = "MANUAL09"
        case manualImage_10 = "MANUAL_IMG10"
        case manual_10 = "MANUAL10"
        case manualImage_11 = "MANUAL_IMG11"
        case manual_11 = "MANUAL11"
        case manualImage_12 = "MANUAL_IMG12"
        case manual_12 = "MANUAL12"
        case manualImage_13 = "MANUAL_IMG13"
        case manual_13 = "MANUAL13"
        case manualImage_14 = "MANUAL_IMG14"
        case manual_14 = "MANUAL14"
        case manualImage_15 = "MANUAL_IMG15"
        case manual_15 = "MANUAL15"
        case manualImage_16 = "MANUAL_IMG16"
        case manual_16 = "MANUAL16"
        case manualImage_17 = "MANUAL_IMG17"
        case manual_17 = "MANUAL17"
        case manualImage_18 = "MANUAL_IMG18"
        case manual_18 = "MANUAL18"
        case manualImage_19 = "MANUAL_IMG19"
        case manual_19 = "MANUAL19"
        case manualImage_20 = "MANUAL_IMG20"
        case manual_20 = "MANUAL20"
        
        case tip = "RCP_NA_TIP" // 저감 조리법Tip
    }
}
