//
//  ProductsViewModel.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//
import Foundation
import Combine

class ProductsViewModel: ObservableObject {
    
    // MARK: - Inner Types

    struct Dependencies {
       var classifiedsService: ProductsDataProvider
    }
    
    // MARK: - Properties
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var dependencies: Dependencies
    
    // MARK: - Initialization method
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    func viewModelForItem(item: Product) -> ProductDetailViewModel {
        return ProductDetailViewModel(item: item)
    }
    
    func fetchListings() async {
        isLoading = true
        do {
            let items = try await dependencies.classifiedsService.fetchListings()
            DispatchQueue.main.async {
                self.products = items
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
