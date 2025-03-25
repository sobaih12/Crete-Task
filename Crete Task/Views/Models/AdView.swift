//
//  AdView.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 25/03/2025.
//


import SwiftUI

struct AdView: View {
    let ad: Ad
    
    var body: some View {
        AsyncImage(url: URL(string: ad.image ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(height: 200)
        } placeholder: {
            ProgressView()
        }
    }
}
