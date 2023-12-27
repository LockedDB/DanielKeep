import SwiftUI

struct ListView: View {
    var list: NotesList?
    
    var body: some View {
        Text(list?.name ?? "")
    }
}

#Preview {
    ListView(list: NotesList.sampleData()[0])
}
