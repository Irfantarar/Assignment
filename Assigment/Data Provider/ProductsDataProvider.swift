//
//  ProductsDataProvider.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation

// MARK: - ProductsDataProvider
protocol ProductsDataProvider {
    func fetchListings() async throws -> [Product]
}

// MARK: - ProductsDataProvider

class ProductsDataProviderImpl: ProductsDataProvider {
    
    func fetchListings() async throws -> [Product] {
        let url = APIEndpoints.fetchListings.url
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(ProductResponse.self, from: data)
            return response.results ?? []
        } catch {
            // Handle specific errors or rethrow as needed
            throw error
        }
    }
}
