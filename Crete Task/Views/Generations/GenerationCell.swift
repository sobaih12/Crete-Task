//
//  GenerationCell.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 25/03/2025.
//

import SwiftUI

struct GenerationCell: View {

    let car : Car
    @Binding var compareCount: Int

    @State var isCompare = false
    @State var isFavorite = false
    @State var isExpanding = false
    @State private var visibleAttributes: [String] = []

    var body: some View {
        VStack{
            if ((car.extraAttributes?.isEmpty) == nil) {
                AsyncImage(url: URL(string: car.modelImage ?? "")) { image in
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
                Text(car.model ?? "unknown")
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .foregroundColor(.black)
                Text(car.year ?? "2020")
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundColor(Color(hex: "#969696"))
                
                Divider()
                    .frame(height: 1)
            }
            
            HStack {
                VStack(alignment: .leading){
                    Text(car.name ?? "unknown")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text("\(car.price ?? 0)")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .foregroundColor(Color(hex: "#EB8855"))
                }
                Spacer()
                
                Image(isCompare ? .compareColored : .compare)
                    .resizable()
                    .frame(width: 77,height: 64)
                    .onTapGesture {
                        isCompare.toggle()
                        if isCompare {
                            compareCount += 1
                        } else {
                            compareCount -= 1
                        }
                    }
                Image(isFavorite ? .starColored : .star)
                    .resizable()
                    .frame(width: 44,height: 44)
                    .onTapGesture {
                        isFavorite.toggle()
                    }
                
            }
            if ((car.extraAttributes?.isEmpty) != nil) {
                Divider()
                    .frame(height: 1)
                HStack{
                    HStack {
                        Image(isExpanding ? .differenceColored : .difference)
                            .resizable()
                            .frame(width: 18, height: 18)
                        
                        Text("\(car.extraAttributes?.count ?? 0) Differences")
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color(hex:isExpanding ? "#EB8855": "#969696"))
                        
                        Spacer()
                        
                        Image(systemName:isExpanding ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 12, height: 7)
                            .foregroundColor(Color(hex:isExpanding ? "#EB8855": "#969696"))
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isExpanding.toggle()
                                    visibleAttributes = []
                                    if isExpanding {
                                        revealAttributes(car.extraAttributes ?? [])
                                    }
                                }
                            }
                        
                    }.padding(.top,4)
                }
                if isExpanding {
                    VStack {
                        ForEach(visibleAttributes, id: \.self) { attribute in
                            HStack {
                                Text("+ \(attribute)")
                                    .font(.custom("Poppins-LightItalic", size: 14))
                                    .foregroundColor(Color(hex: "#3D3D3D"))
                                    .transition(.opacity.combined(with: .move(edge: .leading)))
                                Spacer()
                            }
                        }
                    }
                }

            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 0.5)
    }
    private func revealAttributes(_ attributes: [String]) {
        for (index, attribute) in attributes.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                withAnimation(.easeInOut) {
                    visibleAttributes.append(attribute)
                }
            }
        }
    }
}

