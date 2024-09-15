//
//  APIEndpoints.swift
//  NBAssigment
//
//  Created by Muhammad Irfan Tarar on 15/09/2024.
//

import Foundation

enum APIEndpoints {
    case fetchListings
    
    var url: URL {
        switch self {
        case .fetchListings:
            return URL(string: "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer")!
        }
    }
}
