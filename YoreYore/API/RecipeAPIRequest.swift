//
//  RecipeAPIRequest.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import Foundation
import Alamofire

enum RecipeAPIRequest {
    case foodType(type: ClassifyList, startIdx: Int, endIdx: Int)
    case searchWithIngredients(type: ClassifyList, ingredients: [String], startIdx: Int, endIdx: Int)
    
    var baseURL: URL {
        return URL(string: "https://openapi.foodsafetykorea.go.kr/api/\(APIKey.recipe)/COOKRCP01/json/")!
    }
    
    var getMethod: HTTPMethod {
        return .get
    }
    
    var endpoint: URL {
        switch self {
        case .foodType(let type, let startIdx, let endIdx):
            // 음식종류를 전체로 했다면 파라메터 넘어가지 않음
            if type == .all {
                return URL(string: "\(baseURL)\(startIdx)/\(endIdx)/")!
            }
            let query = type.classifyName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: "\(baseURL)\(startIdx)/\(endIdx)/RCP_PAT2=\(query)")!
        case .searchWithIngredients(let type, let ingredients, let startIdx, let endIdx):
            var urlString = ""
            if type == .all {
                urlString = "\(baseURL)\(startIdx)/\(endIdx)/"
            } else {
                let query = type.classifyName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                urlString = "\(baseURL)\(startIdx)/\(endIdx)/RCP_PAT2=\(query)&"
            }
            for item in ingredients {
                let ingredient = item.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                urlString += "RCP_PARTS_DTLS=\(ingredient)&"
            }
            urlString.removeLast() // 마지막 &문자 삭제
            
            return URL(string: urlString)!
        }
    }
}
