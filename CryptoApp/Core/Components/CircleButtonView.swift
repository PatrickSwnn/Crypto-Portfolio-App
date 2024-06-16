//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/04/2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    var icon:String
    
    
    var body: some View {
        VStack{
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .frame(width:50,height:50)
                .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
                    .shadow(color:Color.theme.accent.opacity(0.25), radius: 10)
                
                
                )
                .padding()
        }
    }
}

struct CircleButtonView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(icon: "heart.fill")
                .padding()
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(icon: "heart.fill")
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
