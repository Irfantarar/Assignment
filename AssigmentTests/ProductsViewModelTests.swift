//
//  ProductsViewModelTests.swift
//  NBAssigmentTests
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import XCTest
@testable import NBAssigment

class ProductsViewModelTests: XCTestCase {

    private var mockService: MockProductsDataProvider!
    private var viewModel: ProductsViewModel!

    override func setUp() {
        super.setUp()
        mockService = MockProductsDataProvider()
        viewModel = ProductsViewModel(dependencies: .init(classifiedsService: mockService))
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchListingsSuccess() async throws {
        mockService.mockProducts = [
            Product(id: "1", name: "Product 1", price: "$10", createdAt: "2024-09-14", imageIDs: [], imageURLs: [], imageURLsThumbnails: [])
        ]
        
        await viewModel.fetchListings()
        
        let exp = XCTestExpectation(description: "Wait for Main Thread")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            exp.fulfill()
        }
        await fulfillment(of: [exp], timeout: 2.0)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.products.count, 1)
    }

    func testFetchListingsFailure() async throws {
        mockService.shouldFail = true

        await viewModel.fetchListings()
        
        let exp = XCTestExpectation(description: "Wait for Main Thread")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            exp.fulfill()
        }
        await fulfillment(of: [exp], timeout: 2.0)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.products.count, 0)
    }
    
    func testIsLoadingState() async throws {
        mockService.mockProducts = [
            Product(id: "1", name: "Product 1", price: "$10", createdAt: "2024-09-14", imageIDs: [], imageURLs: [], imageURLsThumbnails: [])
        ]
        
        let isLoadingStartExpectation = expectation(description: "Expected isLoading to be true while fetching listings.")
        let isLoadingEndExpectation = expectation(description: "Expected isLoading to be false after fetching listings completes.")
        
        let cancellable = viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if isLoading {
                    isLoadingStartExpectation.fulfill()
                } else {
                    isLoadingEndExpectation.fulfill()
                }
            }
        
        let fetchListingsTask = Task {
            await viewModel.fetchListings()
        }
        
        await fulfillment(of: [isLoadingStartExpectation], timeout: 2.0)
        
        await fetchListingsTask.value
        
        await fulfillment(of: [isLoadingEndExpectation], timeout: 2.0)
        
        cancellable.cancel()
    }

    

}
