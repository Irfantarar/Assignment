//
//  Product.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: String?
    let name: String?
    let price: String?
    let createdAt: String?
    let imageIDs: [String]?
    let imageURLs: [String]?
    let imageURLsThumbnails: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case name, price
        case createdAt = "created_at"
        case imageIDs = "image_ids"
        case imageURLs = "image_urls"
        case imageURLsThumbnails = "image_urls_thumbnails"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    var key: String?
}
