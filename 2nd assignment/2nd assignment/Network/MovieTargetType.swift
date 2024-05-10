//
//  MovieTargetType.swift
//  2nd assignment
//
//  Created by 왕정빈 on 2024/05/10.
//

import Foundation

import Moya

enum MovieTargetType {
    case getMovieName(date: String)
}

extension MovieTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieName:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMovieName(let date):
            let parameter: [String: Any] = [
                "targetDt": date
            ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMovieName:
            return ["Content-Type": "application/json"]
        }
    }
}
