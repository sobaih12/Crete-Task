//
//  BrandsScreen.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import SwiftUI

struct BrandsScreen: View {
    
    @StateObject private var viewModel = BrandsViewModel()
    @State private var selectedBrand: Brand?
    
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationStack {
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
                    Text("New Cars")
                        .font(.custom("Poppins-Medium", size: 22))
                        .foregroundColor(.black)
                        .padding(.top, 22)
                    
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search Brands", text: $viewModel.searchText)
                                .foregroundColor(.black)
                                .font(.custom("Poppins-Regular", size: 16))

                        }
                        .padding(.horizontal, 10)
                        .frame(height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                        
                        ZStack {
                            Image("filter_icon")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(2)
                        }
                        .frame(width: 40, height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(viewModel.filteredBrands, id: \.id) { brand in
                                BrandCell(brand: brand)
                                    .onTapGesture {
                                        selectedBrand = brand
                                    }
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetchBrands()
                        }
                    }
                    
                    Spacer()
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .task {
                await viewModel.fetchBrands()
            }
            .navigationDestination(item: $selectedBrand) { brand in
                ModelsScreen(brand: brand)
            }
        }
    }
}


#Preview {
    BrandsScreen()
}
