//
//  ProductDetail.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation
import SwiftUI

// MARK: - ProductDetailView
struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                itemImageView
                itemInfoView
            }
            .padding()
        }
        .background(Color.gray.opacity(0.05))
        .navigationTitle(viewModel.itemName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var itemImageView: some View {
        Group {
            if let url = viewModel.itemImageUrl {
                ZStack(alignment: .bottom) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(height: 350)
                    }
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.05), Color.gray.opacity(0.05)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                }
                .frame(height: 350)
                .cornerRadius(8)
                .shadow(radius: 5)
            } else {
                Rectangle()
            }
        }
    }
    
    private var itemInfoView: some View {
        VStack(alignment: .leading, spacing: 20) {
            ItemDetailRow(label: "Name", value: viewModel.itemName)
            Divider()
            ItemDetailRow(label: "Price", value: viewModel.itemPrice)
            Divider()
            ItemDetailRow(label: "Listed on", value: viewModel.itemListedDate)
        }
        .padding()
    }
}

// MARK: - ItemDetailRow
struct ItemDetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(.black.opacity(0.8))
            Spacer()
            Text(value)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black.opacity(0.7))
        }
    }
}
