//
//  NotesViewModel.swift
//  DanielKeep
//
//  Created by Dani Benet on 27/12/23.
//

import Foundation

class NotesViewModel: ObservableObject {
    @Published var noteLists: [NotesList]
    
    init(noteLists: [NotesList]) {
        self.noteLists = noteLists
    }
}
