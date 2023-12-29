import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Note.title) var notes: [Note]
    @State private var isAddNoteSheetPresented = false
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                cardsGrid()
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

extension ContentView {
    
    
    private func cardsGrid() -> some View {
        
        let columns = [
            GridItem(.flexible(), spacing: nil, alignment: .topLeading),
            GridItem(.flexible(), spacing: nil, alignment: .topLeading)
        ]
        
        return LazyVGrid(columns: columns) {
            ForEach(notes) { note in
                noteCard(note: note)
            }
        }
        .padding(.horizontal, 8)
    }
    
    private func noteCard(note: Note) -> some View {
        return VStack(alignment: .leading) {
            Text(note.title)
            if !note.content.isEmpty {
                Text(note.content)
                    .font(.body)
                    .fontWeight(.light)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(backgroundColor(for: note))
        .clipShape(.rect(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(.ultraThinMaterial, lineWidth: 1.5)
        )
    }
    
    func backgroundColor(for note: Note) -> Color {
        if let bgColorHex = note.bgColor {
            return Color(hex: bgColorHex)
        } else {
            return Color(UIColor.systemBackground)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Note.self, configurations: config)
    
    
    var note = Note(title: "Note", content: "Empty Note")
    container.mainContext.insert(note)
    
    note = Note(title: "Example Note title bit longer", content: "Example content")
    container.mainContext.insert(note)
    
    note = Note(title: "Shorther ", content: "Example content")
    container.mainContext.insert(note)
    
    note = Note(title: "Example Note extra large", content: "Example content with a super long description omg where is this going to end.", bgColor: Color.orange)
    container.mainContext.insert(note)
    
    note = Note(title: "Example Note", content: "Example content")
    container.mainContext.insert(note)
    
    return ContentView()
        .modelContainer(container)
}
