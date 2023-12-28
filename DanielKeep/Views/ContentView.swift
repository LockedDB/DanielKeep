import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Note.title) var notes: [Note]
    @State private var isAddNoteSheetPresented = false
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) {
                    Text($0.title)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(notes[index])
                    }
                }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isAddNoteSheetPresented) { AddNoteView() }
            .toolbar {
                if !notes.isEmpty {
                    Button("Add Note", systemImage: "plus") {
                        isAddNoteSheetPresented = true
                    }                    
                }
            }
            .overlay {
                if notes.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Notes", systemImage: "list.clipboard")
                    }, description: {
                        Text("Start addding notes to see your list.")
                    }, actions: {
                        Button("Add Note") { isAddNoteSheetPresented = true }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview { ContentView() }
