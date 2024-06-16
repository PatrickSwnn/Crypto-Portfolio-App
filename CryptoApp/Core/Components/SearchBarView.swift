//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 10/05/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
                
            TextField("Search Something...", text: $searchText)
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
                .textInputAutocapitalization(.never)
                
                .foregroundStyle(Color.theme.accent)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .opacity(searchText.isEmpty ? 0 : 1)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                        
                    }
                ,alignment: .trailing
                
                )
            
        
            
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius:35)
            .fill(Color.theme.background)
            .shadow(color:Color.theme.accent.opacity(0.3),radius: 3)
        
            
            
        
        
        )
        .padding()
    }
}

struct SearchBarView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
        }
    }
}
