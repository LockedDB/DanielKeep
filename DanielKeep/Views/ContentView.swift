import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Note.title) var notes: [Note]
    @State private var isAddNoteSheetPresented = false
    @Environment(\.modelContext) var context
    
    @State private var searchText: String = ""
    @State private var selectedNote: Note?
    @State private var pushView = false
    
    func filteredNotes() -> [Note] {
        guard !searchText.isEmpty else { return notes }
        
        return notes.filter { note in
            note.title.lowercased().contains(searchText.lowercased()) ||
            note.content.lowercased().contains(searchText.lowercased())
        }
    }
    
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
                if filteredNotes().isEmpty {
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
            .searchable(text: $searchText)
            .overlayPreferenceValue(TAnchorKey.self, { value in
                GeometryReader { geometry in
                    ForEach(filteredNotes()) { note in
                        if let anchor = value[note.title] {
                            let rect = geometry[anchor]
                            noteCard(note: note)
                                .frame(width: rect.width, height: rect.height)
                                .offset(x: rect.minX, y: rect.minY)
                                .allowsHitTesting(false)
                        }
                    }
                }
            })
            .navigationDestination(isPresented: $pushView) {
                AddNoteView()
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
            ForEach(filteredNotes()) { note in
                noteCard(note: note)
                    .anchorPreference(key: TAnchorKey.self, value: .bounds, transform: { anchor in
                        return [note.title: anchor]
                    })
                    .onTapGesture {
                        selectedNote = note
                        pushView.toggle()
                    }
            }
        }
        .padding(.horizontal)
    }
    
    private func noteCard(note: Note) -> some View {
        return VStack(alignment: .leading) {
            Text(note.title)
                .foregroundStyle(.black)
            if !note.content.isEmpty {
                Text(note.content)
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(note.noteColor.color)
        .clipShape(.rect(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(.ultraThinMaterial, lineWidth: 1.5)
        )
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
    
    note = Note(title: "Example Note extra large", content: "Example content with a super long description omg where is this going to end.", bgColor: NoteColor.aka)
    container.mainContext.insert(note)
    
    note = Note(title: "Example Note", content: "Example content")
    container.mainContext.insert(note)
    
    return ContentView()
        .modelContainer(container)
}
