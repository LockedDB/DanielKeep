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
    
    // Form
    @State private var title = ""
    @State private var content = ""
    @State private var background: NoteColor = NoteColor.transparent
    
    @State private var isColorPickerPresent = false
    
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
        NavigationStack {
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
            
            colorPicker()
        }
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem {
                Button(action: saveNote, label: {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundStyle(.black)
                        .font(.subheadline)
                })
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {dismiss()}, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .font(.subheadline)
                })
            }
        }
    }
    
    @ViewBuilder
    private func colorPicker() -> some View {
        ColorPickerButton(
            onPress: { isColorPickerPresent = true }
        )
        .background(background.color)
        .sheet(isPresented: $isColorPickerPresent) {
            ColorPickerSheetView(currentColor: $background)
                .presentationDetents([.height(120)])
        }
    }
}

#Preview {
    DetailView(note: Note(title: "Sample title with a super large note", content: "Sample Content with a long text, enough to fit a couple lines.", bgColor: NoteColor.aka))
}
