//
//  ColorPickerSheetView.swift
//  DanielKeep
//
//  Created by Dani Benet on 29/12/23.
//

import SwiftUI

enum BgColors: String, CaseIterable {
    case red = "#FF0000"
    case green = "#00FF00"
    case blue = "#0000FF"
    case yellow = "#FFFF00"
    case purple = "#800080"
    case orange = "#FFA500"
    case black = "#000000"
    case white = "#FFFFFF"
    case pink = "#FFC0CB"
    case teal = "#008080"
    
    var color: Color {
        return Color(hex: self.rawValue)
    }
}

struct ColorPickerSheetView: View {

    @Binding var currentColor: Color
    
    var body: some View {
        VStack {
            
            Text("Colours")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(
                        BgColors.allCases,
                        id: \.hashValue
                    ) { bgColor in
                        Button(
                            action: { changeColor(color: bgColor.color) }
                        ) {
                            Circle()
                                .fill(bgColor.color)
                                .stroke(.ultraThickMaterial, lineWidth: 2)
                                .frame(width: 45, height: 45)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    func changeColor(color: Color) {
        withAnimation {
            currentColor = color
        }
    }
}

#Preview {
    // On preview this doesn't work
    @State var currentColor: Color = Color.white
    
    return VStack {
        ColorPickerSheetView(currentColor: $currentColor)
            .background(currentColor)
    }
    
}
