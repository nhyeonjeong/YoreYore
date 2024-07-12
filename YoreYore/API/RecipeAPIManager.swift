//
//  RecipeAPIManager.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import Foundation
import Alamofire

enum RecipeAPIError: Error {
    case noData
    case invalidResponse
}

final class RecipeAPIManager {
    static let shared = RecipeAPIManager() // 싱글톤
    private init() {
        
    }
    func fetchRecipe<T: Decodable>(type: T.Type, api: RecipeAPIRequest, completionHandler: @escaping (Result<T?, RecipeAPIError>) -> Void) {
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
                dump(success)
                completionHandler(.success(success))
            case .failure(_):
                print("RecipeAPIManager fetchRecipe failure")
                if let data = response.data {
                    completionHandler(.failure(.noData))
                }
                completionHandler(.failure(.invalidResponse))
            }
        }
    }
}
