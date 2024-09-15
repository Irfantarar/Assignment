//
//  ProductDetailViewModel.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation
import SwiftUI

class ProductDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var item: Product
    
    var itemImageUrl: URL? {
        guard let imageUrl = item.imageURLs?.first else { return nil }
        return URL(string: imageUrl)
    }
    
    var itemName: String {
        item.name ?? "Unknown Item"
    }
    
    var itemPrice: String {
        item.price ?? "Price not available"
    }
    
    var itemListedDate: String {
        guard let createdAtString = item.createdAt else {
            return "Date not available"
        }
        let createdAtDate = DateFormatterUtility.shared.parseDate(from: createdAtString)
        return DateFormatterUtility.shared.displayDateFormatter.string(from: createdAtDate)
    }
    
    // MARK: - Initialization method
    init(item: Product) {
        self.item = item
    }
}
