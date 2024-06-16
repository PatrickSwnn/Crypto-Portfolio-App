//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/04/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var isAnimated : Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(isAnimated ? 1.0 : 0.0)
            .opacity(isAnimated ? 0.0 : 1.0)
            .animation(isAnimated ? .easeInOut(duration: 1) : .none)
            .foregroundStyle(Color.theme.red)

       
    
    }
}

#Preview {
    CircleButtonAnimationView(isAnimated: .constant(false))
        .foregroundStyle(.red)
        .padding()
        .frame(width:350,height:350)
    
}
