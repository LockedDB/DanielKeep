import SwiftUI

struct ListView: View {
    var list: NotesList?
    
    var body: some View {
        ZStack {
            
            if let list = list {
                Text(list.name)
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
