//
//  ProductDetailViewTests.swift
//  NBAssigmentTests
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NBAssigment


class ProductDetailViewTests: XCTestCase {
    
    var mockViewModel: ProductDetailViewModel!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        mockViewModel = nil
        super.tearDown()
    }
    
    func testProductDetailViewDisplaysCorrectInfo() throws {
        let mockProduct = Product(id: "1",
                                  name: "Test Item",
                                  price: "$10", createdAt: "2024-09-14",
                                  imageIDs: [],
                                  imageURLs: [],
                                  imageURLsThumbnails: [])
        
        mockViewModel = ProductDetailViewModel(item: mockProduct)
        let view = ProductDetailView(viewModel: mockViewModel)
        
        // Act
        let nameText = try view.inspect().find(text: mockViewModel.itemName)
        let priceText = try view.inspect().find(text: mockViewModel.itemPrice)
        
        // Assert
        XCTAssertEqual(try nameText.string(), mockViewModel.itemName)
        XCTAssertEqual(try priceText.string(), mockViewModel.itemPrice)
    }
}
