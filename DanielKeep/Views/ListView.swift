import SwiftUI

struct ListView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var list: NotesList?
    @State private var showAddNoteForm = false
    
    var body: some View {
        ZStack {
            
            if let list = list {
                List(list.notes) { note in
                    Text(note.title)
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
                    AddNoteView(list: list, showForm: $showAddNoteForm)
                }
            } else {
                Text("Please select a list")
                    .navigationTitle("")
            }
            
        }
    }
    
}

#Preview {
    ListView(list: NotesList.sampleData()[0])
        .environmentObject(NavigationModel())
}
