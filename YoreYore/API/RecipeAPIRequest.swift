//
//  RecipeAPIRequest.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import Foundation
import Alamofire

enum RecipeAPIRequest {

    case foodType(type: SearchViewModel.ClassifyList)
    case searchWithType(type: SearchViewModel.ClassifyList, search: String)
    
    var baseURL: URL {
        return URL(string: "https://openapi.foodsafetykorea.go.kr/api/\(APIKey.recipe)/COOKRCP01/json/1/5/")!
    }
    
    var getMethod: HTTPMethod {
        return .get
    }
    
    var endpoint: URL {
        switch self {
        case .foodType(let type):
//            guard let queryType = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//                print("queryType으로 encoding실패")
//                return
//            }
            let query = type.classifyName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: "\(baseURL)RCP_PAT2=\(query)")!
        case .searchWithType(let type, let search):
            let query = type.classifyName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let query2 = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: "\(baseURL)RCP_PAT2=\(query)&RCP_NM=\(query2)")!
        }
    }
    
    /*
    var parameter: Parameters {
        switch self {
        case .foodType(let type):
            let queryType = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            guard let queryType else {
                print("query Encoding Failed")
                return ["": ""]
            }
            return ["RCP_PAT2": queryType]
        case .searchWithType(let type, let search):
            let queryType = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let querySearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            guard let queryType, let querySearch else {
                print("query Encoding Failed")
                return ["": ""]
            }
//            print("queryType: \(queryType)")
            return ["RCP_PAT2": queryType, "RCP_NM": querySearch]
        }
    }
     */
}
