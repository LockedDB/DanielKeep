//
//  DetailView.swift
//  DanielKeep
//
//  Created by Dani Benet on 2/1/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var background: NoteColor = NoteColor.transparent
    
    var note: Note?
    
    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title)
                    .font(.title)
                TextField("Description", text: $content, axis: .vertical)
                    .lineLimit(nil)
            }
            .formStyle(.columns)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(background.color)
        .toolbar { toolbarItems }
        .task {
            /// If a note has been provided, load it into the text fields
            guard note != nil else { return }
            
            title = note?.title ?? ""
            content = note?.content ?? ""
            background = note?.noteColor ?? NoteColor.transparent
        }
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItemGroup {
                Button(action: { }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundStyle(.black)
                })
            }
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(action: { dismiss() }, label: {
                    Text("Cancel")
                        .foregroundStyle(.black)
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(note: Note(title: "Sample title", content: "Sample Content with a long text, enough to fit a couple lines.", bgColor: NoteColor.aka))
    }
}
