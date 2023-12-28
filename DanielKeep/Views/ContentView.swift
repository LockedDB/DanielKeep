import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var notesViewModel: NotesViewModel
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        NavigationSplitView {
            List(notesViewModel.noteLists, selection: $navigationModel.selectedList) {
                NavigationLink($0.name, value: $0)
            }
            .navigationTitle("Lists")
        } detail: {
            
            // TODO: For some reason the title appears inlined on the first second
            ListView(list: navigationModel.selectedList)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationModel())
        .environmentObject(
            NotesViewModel(
                noteLists: NotesList.sampleData()
            )
        )
}
