import SwiftUI

struct ListView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var list: NotesList?
    @State private var showAddNoteForm = false
    
    var body: some View {
        ZStack {
            
            if let list = list {
                List(list.notes) { note in
                    VStack(alignment: .leading) {
                        Text(note.title)
                        
                        if note.description != "" {
                            Text(note.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .navigationTitle(list.name)
                .toolbar {
                    ToolbarItem {
                        Button(action: { showAddNoteForm.toggle() }, label: {
                            Label("Add note", systemImage: "plus")
                        })
                    }
                }
                .sheet(isPresented: $showAddNoteForm) {
                    AddNoteView(list: list)
                }
            } else {
                Text("Please select a list")
                    .navigationTitle("")
            }
            
        }
    }
    
}

#Preview {
    NavigationStack {

        ListView(list: NotesList.sampleData()[0])
            .environmentObject(NavigationModel())
    }
}
