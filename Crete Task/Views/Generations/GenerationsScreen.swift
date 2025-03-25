//
//  GenerationsScreen.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 25/03/2025.
//

import SwiftUI

struct GenerationsScreen: View {
    let model: Model
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
                        Text("\(model.parentBrand ?? "Unknown")")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 22)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

