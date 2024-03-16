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
    var largeImage: String // https가 아닐경우 가공해서 다시 저장하기 때문에 var로 변경
    let ingredients: String

    let manuals: [Manual]
    let tip: String
    
    private enum CodingKeys: String, CodingKey {
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
//        self.largeImage = try container.decode(String.self, forKey: .largeImage)
        self.ingredients = try container.decode(String.self, forKey: .ingredients)
        self.tip = try container.decode(String.self, forKey: .tip)
        
        var largeImageString = try container.decode(String.self, forKey: .largeImage)
        self.largeImage = largeImageString.setHttps()
        
        var manuals: [Manual] = []
        for index in 1...20 {
            let imageKey = "MANUAL_IMG" + String(format: "%02d", index)
            let textKey = "MANUAL" + String(format: "%02d", index)
            
            let image = try container.decode(String.self, forKey: .init(rawValue: imageKey)!)
            let text = try container.decode(String.self, forKey: .init(rawValue: textKey)!)
            if text == "" && image == "" { break }
            
            // http라면 https로 바꾸기
            manuals.append(Manual(image: image.setHttps(), content: text.setHttps()))
        }
        self.manuals = manuals
    }
}

  
