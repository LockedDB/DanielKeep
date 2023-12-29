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
    
    @State private var isColorPickerPresented = false
    
    @State private var currentNoteColor: NoteColor = NoteColor.transparent
    
    var body: some View {
        NavigationStack {
            VStack {
                NoteFormView(title: $title, description: $description)
                Spacer()
                ColorPickerButton(isColorPickerPresented: $isColorPickerPresented)
            }
            .background(currentNoteColor.color)
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarItems }
        }
        .sheet(isPresented: $isColorPickerPresented) {
            ColorPickerSheetView(currentColor: $currentNoteColor)
                .presentationDetents( [.height(120)] )
        }
        
    }
    
    func saveNote() {
        let newNote = Note(title: title, content: description, bgColor: currentNoteColor)
        context.insert(newNote)
        dismiss()
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
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

#Preview { AddNoteView() }
