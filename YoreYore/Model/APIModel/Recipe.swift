//
//  Recipe.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/10.
//

import Foundation

struct Recipe: Decodable, Hashable {
    
    struct Manual: Hashable {
        let image: String
        let content: String
    }
    
    let id: String
    let foodName: String
    let way: String
    let footType: String
    let weight: String
    let kal: String
    let smallImage: String
    let largeImage: String
    let ingredients: String
    /*
     let manualImage_1: String
     let manual_1: String
     let manualImage_2: String
     let manual_2: String
     let manualImage_3: String
     let manual_3: String
     let manualImage_4: String
     let manual_4: String
     let manualImage_5: String
     let manual_5: String
     let manualImage_6: String
     let manual_6: String
     let manualImage_7: String
     let manual_7: String
     let manualImage_8: String
     let manual_8: String
     let manualImage_9: String
     let manual_9: String
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
     */
    let manuals: [Manual]
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
        
        case manualImage_1 = "MANUAL_IMG01"
        case manual_1 = "MANUAL01"
        case manualImage_2 = "MANUAL_IMG02"
        case manual_2 = "MANUAL02"
        case manualImage_3 = "MANUAL_IMG03"
        case manual_3 = "MANUAL03"
        case manualImage_4 = "MANUAL_IMG04"
        case manual_4 = "MANUAL04"
        case manualImage_5 = "MANUAL_IMG05"
        case manual_5 = "MANUAL05"
        case manualImage_6 = "MANUAL_IMG06"
        case manual_6 = "MANUAL06"
        case manualImage_7 = "MANUAL_IMG07"
        case manual_7 = "MANUAL07"
        case manualImage_8 = "MANUAL_IMG08"
        case manual_8 = "MANUAL08"
        case manualImage_9 = "MANUAL_IMG09"
        case manual_9 = "MANUAL09"
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.foodName = try container.decode(String.self, forKey: .foodName)
        self.way = try container.decode(String.self, forKey: .way)
        self.footType = try container.decode(String.self, forKey: .footType)
        self.weight = try container.decode(String.self, forKey: .weight)
        self.kal = try container.decode(String.self, forKey: .kal)
        self.smallImage = try container.decode(String.self, forKey: .smallImage)
        self.largeImage = try container.decode(String.self, forKey: .largeImage)
        self.ingredients = try container.decode(String.self, forKey: .ingredients)
        self.tip = try container.decode(String.self, forKey: .tip)
        
        var manuals: [Manual] = []
        for index in 1...20 {
            let imageKey = "MANUAL_IMG" + String(format: "%02d", index)
            let textKey = "MANUAL" + String(format: "%02d", index)
            
            let image = try container.decode(String.self, forKey: .init(rawValue: imageKey)!)
            let text = try container.decode(String.self, forKey: .init(rawValue: textKey)!)
            if text == "" && image == "" { break }
            manuals.append(Manual(image: image, content: text))
        }
        self.manuals = manuals
        print("init manuals: \(manuals)")
    }
}

  
