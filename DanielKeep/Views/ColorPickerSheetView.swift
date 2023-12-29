//
//  ColorPickerSheetView.swift
//  DanielKeep
//
//  Created by Dani Benet on 29/12/23.
//

import SwiftUI

enum NoteColor: CaseIterable, Codable {
    case aka,
         bamboo,
         beish,
         forest,
         metal,
         pig,
         pika,
         sky,
         submarine,
         sun,
         tinky,
         transparent
    
    var color: Color {
        Color("\(self)")
    }
}

struct ColorPickerSheetView: View {
    
    @Binding var currentColor: NoteColor
    
    var body: some View {
        VStack {
            
            Text("Colours")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    Button(action: { changeColor(color: NoteColor.transparent )}) {
                        Image(systemName: "paintbrush")
                            .frame(width: 45, height: 45)
                            .foregroundStyle(.black)
                            .background(.white)
                            .clipShape(.circle)
                            .overlay {
                                Circle().strokeBorder(.ultraThinMaterial, lineWidth: 2)
                            }
                    }
                    
                    ForEach(NoteColor.allCases, id: \.self) { bgColor in
                        Button(action: { changeColor(color: bgColor) }) {
                            Circle()
                                .fill(bgColor.color)
                                .stroke(.ultraThinMaterial, lineWidth: 2)
                                .frame(width: 45, height: 45)
                                .shadow(radius: 0.1)
                                .padding(.vertical, 2)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    func changeColor(color: NoteColor) {
        withAnimation {
            currentColor = color
        }
    }
    
    
}

#Preview {
    // On preview this doesn't work
    @State var currentColor: NoteColor = NoteColor.transparent
    
    return VStack {
        ColorPickerSheetView(currentColor: $currentColor)
            .background(currentColor.color)
    }
    
}
