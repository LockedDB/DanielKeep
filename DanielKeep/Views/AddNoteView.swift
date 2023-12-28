//
//  AddNoteView.swift
//  DanielKeep
//
//  Created by Dani Benet on 27/12/23.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $date, displayedComponents: [.date])
            }
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup {
                    Button(action: saveNote, label: {
                        Text("Save")
                    })
                }
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
    }
    
    func saveNote() {
        let newNote = Note(title: title, content: description)
        context.insert(newNote)
        dismiss()
    }
}

#Preview {
    AddNoteView()
}
