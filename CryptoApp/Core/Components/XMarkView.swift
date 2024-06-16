//
//  XMarkView.swift
//  CryptoApp
//
//  Created by Swan Nay Phue Aung on 13/05/2024.
//

import SwiftUI

struct XMarkView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Image(systemName:"xmark.circle")
                .font(.headline)
        }

    }
}

#Preview {
    XMarkView()
}
