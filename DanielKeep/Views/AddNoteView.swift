//
//  AddNoteView.swift
//  DanielKeep
//
//  Created by Dani Benet on 27/12/23.
//

import SwiftUI

struct AddNoteView: View {
    var list: NotesList
    @Binding var showForm: Bool
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationStack {
        
            VStack {
                TextField(
                    "Title",
                    text: $title
                )
                .textInputAutocapitalization(.never)
                
                Divider()
                
                ZStack(alignment: .topLeading) {
                    // TextEditor has a default padding that doesn't align well with other elements
                    TextEditor(text: $description)
                        .padding(.horizontal, -3)
                        .padding(.vertical, -4)
                        .font(.body)
                    
                    if description.isEmpty {
                        Text("Description")
                            .foregroundStyle(.placeholder)
                            .padding(.top, 4)
                            .font(.body)
                    }
                }
                
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button(action: addNote, label: {
                        Text("Add")
                    })
                }
            }
            .navigationTitle("Add Note")
        }
    }
    
    func addNote() {
        var newNote = Note(title: title, description: description)
        
        withAnimation {
            list.addNote(note: newNote)
        }
        showForm = false
    }
}

#Preview {
    NavigationStack {
        AddNoteView(
            list: NotesList.sampleData().first!,
            showForm: .constant(false)
        )
    }
}
