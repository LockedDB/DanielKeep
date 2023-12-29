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
    
    @State private var currentBgColor: Color = Color(UIColor.systemBackground)
    
    var body: some View {
        NavigationStack {
            VStack {
                NoteFormView(
                    title: $title,
                    description: $description,
                    currentColor: $currentBgColor
                )
                Spacer()
                ColorPickerButton(isColorPickerPresented: $isColorPickerPresented)
            }
            .background(currentBgColor)
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarItems }
        }
        .sheet(isPresented: $isColorPickerPresented) {
            ColorPickerSheetView(currentColor: $currentBgColor)
                .presentationDetents( [.height(120)] )
        }
        
    }
    
    func saveNote() {
        let newNote = Note(title: title, content: description, bgColor: currentBgColor)
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
