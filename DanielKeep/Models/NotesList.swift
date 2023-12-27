//
//  List.swift
//  DanielKeep
//
//  Created by Dani Benet on 26/12/23.
//

import Foundation

class NotesList: Identifiable, Hashable {
    var name: String
    var notes: [Note]
    var id = UUID()
    
    init(name: String, notes: [Note] = []) {
        self.name = name
        self.notes = notes
    }
    
    func addNote(note: Note) {
        notes.append(note)
    }
    
    static func sampleData() -> Array<NotesList> {
        return [
            NotesList(name: "My Notes", notes: Note.sampleData()),
            NotesList(name: "My Bento Box")
        ]
    }
    
    static func == (lhs: NotesList, rhs: NotesList) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
