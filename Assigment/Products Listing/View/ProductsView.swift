//
//  ContentView.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import SwiftUI

// MARK: - ProductsView
struct ProductsView: View {
    @StateObject private var viewModel: ProductsViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    init(viewModel: ProductsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView {
                Spacer(minLength: 30)
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.products) { item in
                        Button(action: {
                            coordinator.navigateToDetail(for: viewModel.viewModelForItem(item: item))
                        }) {
                            ProductRowView(item: item)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Products")
            .onAppear() {
                Task {
                    await viewModel.fetchListings()
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                destination.view()
            }
        }
    }
}


// MARK: - ProductRowView
struct ProductRowView: View {
    let item: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading) {
                Text(item.name ?? "Unknown")
                    .font(.largeTitle.bold())
                Text(item.price ?? "No Price")
                    .font(.subheadline.bold())
            }
            .foregroundColor(.white)
            
            HStack {
                if let createdAtString = item.createdAt {
                    metricsLabel(for: createdAtString)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(backgroundImage)
        .cornerRadius(16)
        .shadow(color: .gray, radius: 8, x: 4, y: 4)
    }
}


// MARK: - Extension ProductRowView
extension ProductRowView {
    private var backgroundImage: some View {
        ZStack {
            if let imageUrl = item.imageURLs?.first, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            }
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                startPoint: .topLeading,
                endPoint: UnitPoint(x: 0.4, y: 1.0)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func metricsLabel(for createdAtString: String) -> some View {
        let createdAtDate = DateFormatterUtility.shared.parseDate(from: createdAtString)
        return Text("Listed on: \(createdAtDate, formatter: DateFormatterUtility.shared.displayDateFormatter)")
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .font(.caption)
            .background(Color.white)
            .cornerRadius(8)
            .foregroundColor(.gray)
    }
}

// MARK: - Preview
#Preview {
    ProductsView(viewModel: ProductsViewModel(dependencies: ProductsViewModel.Dependencies(classifiedsService: ProductsDataProviderImpl())))
        .environmentObject(Coordinator())
}
