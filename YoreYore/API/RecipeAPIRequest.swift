//
//  RecipeAPIRequest.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import Foundation

enum RecipeAPIRequest {
    
    case trending
    case search(query: String)
    case photo(id: Int)
    
    var baseURL: String {
        return "http://openapi.foodsafetykorea.go.kr/api/sample/COOKRCP01/xml/1/5"
    }
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/week")!
        case .search: // 매개변수르 안써줘도 되긴 함
            return URL(string: baseURL + "search/movie")!
        case .photo(let id):
            return URL(string: baseURL + "movie/\(id)/images")! // 영화 id가 들어가는 부분은 달라질 것이다.
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            ["": ""] // 빈 거 보내는 것도 가능
        case .search(let query):
            ["language": "ko-KR", "query": query]
        case .photo:
            ["":""] // 여기도 딱히 queryString없음
        }
    }
}
