//
//  BrandCell.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//


import SwiftUI

struct BrandCell: View {
    let brand: Brand

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: brand.image ?? "")) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 30)

            Text(brand.name ?? "Unknown")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(1)

        }
        .frame(width: 83, height: 83)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 0.5) 
    }
}
