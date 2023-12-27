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
            ListView(list: navigationModel.selectedList)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationModel())
}