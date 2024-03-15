//
//  RecipeAPIManager.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import Foundation
import Alamofire

final class RecipeAPIManager {
    static let shared = RecipeAPIManager() // 싱글톤
    private init() {
        
    }
    
    func fetchRecipe<T: Decodable>(type: T.Type, api: RecipeAPIRequest, completionHandler: @escaping (T?, Error?) -> Void) {
        
        /*
//        print("api.parameter: \(api.parameter)")
//        print("foodTypeAPI\(api.typeString)------------------------------")
        AF.request(api.endpoint, method: api.getMethod, /*parameters: api.parameter,*/ encoding: URLEncoding(destination: .queryString)).responseString { data in
//            print("response String\(api.typeString)")
            print("data: \(data)")
            print("--------------------------------------------")
        }
         */
        
        
        AF.request(api.endpoint, method: api.getMethod, encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success, nil)
            case .failure(let failure):
                print("RecipeAPIManager fetchRecipe failure")
                
                completionHandler(nil, failure)
            }
        }
        
    }
}
