//
//  MockProductsDataProvider.swift
//  NBAssigmentTests
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation
import XCTest
@testable import NBAssigment

class MockProductsDataProvider: ProductsDataProvider {
    var mockProducts: [Product] = []
    var shouldFail = false
    
    func fetchListings() async throws -> [Product] {
        if shouldFail {
            throw NSError(domain: "Test Error", code: 1, userInfo: nil)
        }
        return mockProducts
    }
}
