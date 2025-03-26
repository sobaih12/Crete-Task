//
//  ModelGridCell.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import SwiftUI

// MARK: - Grid Cell View
struct ModelGridCell: View {
    let model: Model
    
    var body: some View {
        VStack{ // Ensure the VStack is leading
            AsyncImage(url: URL(string: model.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2 - 60, height: 110)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                ZStack{
                    Color.white
                        .frame(height: 110)
                        .cornerRadius(8)
                    ProgressView()
                }
            }
            HStack{
                VStack(alignment: .leading, spacing: 4 ){
                    Text(model.name ?? "unknown")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .foregroundColor(.black)
                    Text(model.attributeValue ?? "2020")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(Color(hex: "#969696"))
                    Text("Starting from")
                        .font(.custom("Poppins-Light", size: 10))
                        .foregroundColor(Color(hex: "#969696"))
                    Text("\(model.price ?? 0)")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .foregroundColor(Color(hex: "#EB8855"))
                }
                Spacer()
            }
            
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 50)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 0.5)
    }
}
