//
//  GenerationsScreen.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 25/03/2025.
//

import SwiftUI

struct GenerationsScreen: View {
    
    @StateObject private var viewModel = GenerationsViewModel()
    @State private var compareCount = 0

    let model: Model
    let brand: Brand
    @Environment(\.dismiss) private var dismiss


    var body: some View {
        NavigationStack{
            ZStack{
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
                    
                    ScrollView {
                        VStack(spacing: 14) {
                            ForEach(viewModel.cars, id: \.self) { car in
                                // there is no parameter retreived called model
                                if car.model == model.name {
                                    GenerationCell(car: car, compareCount: $compareCount)
                                }
                            }
                        }
                        .padding()
                    }

                    Spacer()
                                       
                }
                if compareCount > 0 {
                    FloatingCompareView(compareCount: compareCount)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .task {
                await viewModel.fetchGenerations(brandId: brand.id ?? 0, identificationAttributeId: model.identificationAttributeID ?? 0, identificationAttributeValueId: model.identificationAttributeValueID ?? 0)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

