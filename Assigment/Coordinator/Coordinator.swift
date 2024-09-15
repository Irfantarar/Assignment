//
//  Coordinator.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: [NavigationDestination] = []
    
    func navigateToDetail(for viewModel: ProductDetailViewModel) {
        path.append(NavigationDestination.detail(viewModel))
    }

    func navigate(to destination: NavigationDestination) {
        path.append(destination)
    }

    func pop() {
        path.removeLast()
    }
    
    @ViewBuilder
    func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {
        case .detail(let viewModel):
            ProductDetailView(viewModel: viewModel)
        case .other(let identifier):
            Text("Other view with identifier \(identifier)")
        }
    }
}

enum NavigationDestination {
    case detail(ProductDetailViewModel)
    case other(String)
}

// MARK: - ProductResponse Conformance to `Hashable`
extension NavigationDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .detail(let viewModel):
            hasher.combine(viewModel.item.id)
        case .other(let identifier):
            hasher.combine(identifier)
        }
    }
}

// MARK: - ProductResponse Conformance to `Equatable`
extension NavigationDestination: Equatable {
    static func ==(lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.detail(let lhsItem), .detail(let rhsItem)):
            return lhsItem.item.id == rhsItem.item.id
        case (.other(let lhsIdentifier), .other(let rhsIdentifier)):
            return lhsIdentifier == rhsIdentifier
        default:
            return false
        }
    }
}

extension NavigationDestination {
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .detail(let viewModel):
            ProductDetailView(viewModel: viewModel)
        case .other(let identifier):
            Text("Other view with identifier \(identifier)")
        }
    }
}
