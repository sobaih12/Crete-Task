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
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Text(model.attributeValue ?? "2020")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(hex: "#969696"))
                    Text("Starting from")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Color(hex: "#969696"))
                    Text("\(model.price ?? 0)")
                        .font(.system(size: 18, weight: .semibold))
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
