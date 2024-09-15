//
//  ProductsViewTests.swift
//  NBAssigmentTests
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NBAssigment

class ProductsViewTests: XCTestCase {

    var mockViewModel: ProductsViewModel!
    var coordinator: Coordinator!

    override func setUp() {
        super.setUp()
        let mockService = MockProductsDataProvider()
        mockViewModel = ProductsViewModel(dependencies: .init(classifiedsService: mockService))
        coordinator = Coordinator()
    }
    
    override func tearDown() {
        mockViewModel = nil
        coordinator = nil
        super.tearDown()
    }
    

    // Test that ProductsView displays correct number of product rows
    func testProductsViewDisplaysRows() throws {
        let view = ProductsView(viewModel: mockViewModel)
            .environmentObject(coordinator)
        
        mockViewModel.products = [
            Product(id: "1", name: "Test Item 1", price: "$10", createdAt: "2024-09-14", imageIDs: [], imageURLs: [], imageURLsThumbnails: []),
            Product(id: "2", name: "Test Item 2", price: "$20", createdAt: "2024-09-13", imageIDs: [], imageURLs: [], imageURLsThumbnails: [])
        ]
        
        let rows = try view.inspect().findAll(ProductRowView.self)
        XCTAssertEqual(rows.count, 2)
    }

    // Test that tapping on a product navigates to ProductDetailView
    func testProductRowAction() throws {
        let mockProduct = Product(id: "1", name: "Test Item", price: "$10", createdAt: "2024-09-14", imageIDs: [], imageURLs: [], imageURLsThumbnails: [])
        mockViewModel.products = [mockProduct]
        
        let view = ProductsView(viewModel: mockViewModel)
            .environmentObject(coordinator)

        let rows = try view.inspect().findAll(ProductRowView.self)
        XCTAssertEqual(rows.count, 1, "There should be one ProductRowView")
        
        let lazyVStack = try view.inspect().find(ViewType.LazyVStack.self)
        let button = try lazyVStack.find(ViewType.Button.self)
        try button.tap()
        
        let exp = XCTestExpectation(description: "Wait for navigation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        XCTAssertEqual(coordinator.path.count, 1, "Coordinator path should have one destination")

        guard let lastDestination = coordinator.path.last else {
            XCTFail("Failed to navigate to detail view")
            return
        }
        
        if case .detail(let viewModel) = lastDestination {
            XCTAssertEqual(viewModel.item.id, mockProduct.id)
        } else {
            XCTFail("Wrong destination")
        }
    }
}
