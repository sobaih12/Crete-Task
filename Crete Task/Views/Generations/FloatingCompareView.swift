//
//  FloatingCompareView.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 25/03/2025.
//

import SwiftUI

struct FloatingCompareView: View {
    let compareCount: Int
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(hex: "#EB8855"))
                        .frame(width: 60, height: 60)
                        .shadow(radius: 4)
                        .scaleEffect(compareCount > 0 ? 1.1 : 1.0)
                        .animation(.spring(), value: compareCount)
                    
                    Image(.carBody)
                        .scaleEffect(1.2)
                    
                    Image(.carHead)
                        .scaleEffect(1.2)
                        .padding(.bottom, 22)
                        .padding(.leading, 18)
                        
                    
                    Text("\(compareCount)")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Medium", size: 11))
                        .padding(.bottom,22)
                        .padding(.leading,18)
                }
                .padding()
                .offset(y: compareCount > 0 ? -20 : 100)
                .animation(.easeInOut(duration: 0.3), value: compareCount)
            }
        }
    }
}
