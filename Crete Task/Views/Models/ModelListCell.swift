//
//  ModelListCell.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import SwiftUI

// MARK: - List Cell View
struct ModelListCell: View {
    let model: Model
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: model.image ?? "")) { image in
                image
                    .resizable() 
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 232, height: 128)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                ZStack{
                    Color.white
                        .frame(height: 128)
                        .cornerRadius(8)
                    ProgressView()
                }
            }
            HStack {
                VStack(alignment: .leading){
                    Text(model.name ?? "unknown")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Text(model.attributeValue ?? "2020")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(hex: "#969696"))
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("Starting from")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Color(hex: "#969696"))
                    Text("\(model.price ?? 0)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: "#EB8855"))
                }
                
                
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 0.5)
    }
}
