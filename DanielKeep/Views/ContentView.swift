import SwiftUI

struct ContentView: View {
    private var lists = NotesList.sampleData()
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        NavigationSplitView {
            List(lists, selection: $navigationModel.selectedList) {
                NavigationLink($0.name, value: $0)
            }
            .navigationTitle("Lists")
        } detail: {
            
            // TODO: Transition issue, data is not loaded fast enough so nil state is shown for a split second
            ListView(list: navigationModel.selectedList)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationModel())
}
