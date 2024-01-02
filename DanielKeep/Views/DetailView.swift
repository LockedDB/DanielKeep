//
//  DetailView.swift
//  DanielKeep
//
//  Created by Dani Benet on 30/12/23.
//

import SwiftUI

struct DetailView: View {
    var title: String?
    var content: String?
    var noteColor: NoteColor?
    
    @State private var textTitle = ""
    @State private var textContent = ""
    @State private var currentNoteColor = NoteColor.transparent
    
    var body: some View {
        if let title {
            
            VStack {
                
                TextField("Title", text: $textTitle)
                    .font(.title2)
                TextField("Description", text: $textContent, axis: .vertical)
                    .lineLimit(nil)

                Spacer()
            }
            .anchorPreference(key: TAnchorKey.self, value: .bounds, transform: { anchor in
                return [title ?? "": anchor]
            })
            .padding()
            .background(currentNoteColor.color)
            .onAppear {
                textTitle = title ?? ""
                textContent = content ?? ""
                currentNoteColor = noteColor ?? NoteColor.transparent
            }

        }
    }
}

#Preview {
    DetailView(
        title: "",
        content: "",
        noteColor: .tinky
    )
}
