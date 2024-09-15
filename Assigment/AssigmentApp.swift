//
//  NBAssigmentApp.swift
//  NBAssigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import SwiftUI

@main
struct AssigmentApp: App {
    @StateObject private var coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            let dependencies = ProductsViewModel.Dependencies(classifiedsService: ProductsDataProviderImpl())
            let viewModel = ProductsViewModel(dependencies: dependencies)
            ProductsView(viewModel: viewModel)
                .environmentObject(coordinator)
        }
    }
}
