//
//  DetailView.swift
//  DanielKeep
//
//  Created by Dani Benet on 2/1/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var background: NoteColor = NoteColor.transparent
    
    var note: Note?
    
    // If we received the note by props we are updating, otherwise, we are creating
    func saveNote() {
        if title.isEmpty || content.isEmpty { return }
        
        if note == nil {
            let _note = Note(title: title, content: content, bgColor: background)
            context.insert(_note)
        } else {
            do {
                note?.title = title
                note?.content = content
                note?.noteColor = background
                
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        dismiss()
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title, axis: .vertical)
                    .font(.title)
                TextField("Description", text: $content, axis: .vertical)
                    .fontWeight(.light)
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
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var toolbarItems: some ToolbarContent {
        ToolbarItemGroup {
            Button(action: saveNote, label: {
                Image(systemName: "square.and.arrow.down")
                    .foregroundStyle(.black)
            })
        } 
    }
}

#Preview {
    NavigationStack {
        DetailView(note: Note(title: "Sample title with a super large note", content: "Sample Content with a long text, enough to fit a couple lines.", bgColor: NoteColor.aka))
    }
}
