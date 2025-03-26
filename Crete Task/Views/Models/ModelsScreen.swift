//
//  ModelsScreen.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import SwiftUI

struct ModelsScreen: View {
    
    let brand: Brand
    
    @StateObject private var viewModel = ModelsViewModel()
    @State private var selectedModel: Model?
    @Environment(\.dismiss) private var dismiss
    
    @State var isGrid = false
    @State private var currentPage = 1
    @State private var isFetchingMore = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "#EB8855").lighter(by: 50), .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: UIScreen.main.bounds.height / 2)
                
                Color.white
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.black)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    Text("\(brand.name ?? "Unknown")")
                        .font(.custom("Poppins-Medium", size: 22))
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                
                HStack {
                    Image(isGrid ? .list : .grid)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            isGrid.toggle()
                            Task {
                                currentPage = 1
                            }
                        }
                    
                    Spacer()
                    Image(.sort)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Image(.filter)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                ScrollView {
                    if isGrid {
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(viewModel.models, id: \.vehicleID) { model in
                                ModelGridCell(model: model)
                                    .onTapGesture {
                                        selectedModel = model
                                    }
                                    .onAppear {
                                        loadMoreIfNeeded(model: model)
                                    }
                            }
                        }
                        .padding()
                    } else {
                        VStack(spacing: 14) {
                            ForEach(viewModel.models.indices, id: \.self) { index in
                                if index == 3, viewModel.ads.count > 0 {
                                    let ad = viewModel.ads[0]
                                    AdView(ad: ad)
                                        .frame(height: 200)
                                        .onTapGesture {
                                            if let url = URL(string: ad.url ?? ""), UIApplication.shared.canOpenURL(url) {
                                                UIApplication.shared.open(url)
                                            }
                                        }
                                }

                                if index == 6, viewModel.ads.count > 1 {
                                    let ad = viewModel.ads[1]
                                    AdView(ad: ad)
                                        .frame(height: 200)
                                        .onTapGesture {
                                            if let url = URL(string: ad.url ?? ""), UIApplication.shared.canOpenURL(url) {
                                                UIApplication.shared.open(url)
                                            }
                                        }
                                }

                                
                                ModelListCell(model: viewModel.models[index])
                                    .onTapGesture {
                                        selectedModel = viewModel.models[index]
                                    }
                                    .onAppear {
                                        loadMoreIfNeeded(model: viewModel.models[index])
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    if isFetchingMore {
                        ProgressView()
                    }
                }
                
                Spacer()
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                if viewModel.models.isEmpty {
                    await viewModel.fetchModels(page: currentPage, brandId: brand.id ?? 0, reset: true)
                }
            }
        }
        .navigationDestination(item: $selectedModel) { model in
            GenerationsScreen(model: model,brand: brand)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func loadMoreIfNeeded(model: Model) {
        guard !isFetchingMore else { return }
        
        let thresholdIndex = viewModel.models.index(viewModel.models.endIndex, offsetBy: -3)
        if viewModel.models.firstIndex(where: { $0.vehicleID == model.vehicleID }) == thresholdIndex {
            isFetchingMore = true
            currentPage += 1
            Task {
                await viewModel.fetchModels(page: currentPage, brandId: brand.id ?? 0)
                isFetchingMore = false
            }
        }
    }
}
