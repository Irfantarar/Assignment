//
//  ProductResponse.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    var results: [Product]?
    var pagination: Pagination?
}
