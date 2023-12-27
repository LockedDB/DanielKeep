import SwiftUI

struct ListView: View {
    var list: NotesList?
    
    var body: some View {
        ZStack {
            
            if let list = list {
                List(list.notes) { note in
                    Text(note.title)
                }
                .navigationTitle(list.name)
            } else {
                Text("Please select a list")
                    .navigationTitle("")
            }
            
        }
    }
}

#Preview {
    ListView(list: NotesList.sampleData()[0])
}
