//
//  ColorPickerButtonView.swift
//  DanielKeep
//
//  Created by Dani Benet on 29/12/23.
//

import SwiftUI

struct ColorPickerButton: View {
    @Binding var isColorPickerPresented: Bool

    var body: some View {
        HStack {
            Button(action: { isColorPickerPresented = true }) {
                Image(systemName: "paintpalette")
                    .foregroundStyle(.black)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}
