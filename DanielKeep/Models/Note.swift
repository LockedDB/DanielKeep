//
//  Notes.swift
//  DanielKeep
//
//  Created by Dani Benet on 27/12/23.
//

import Foundation


class Note: Identifiable, Hashable {

    var title: String
    var id = UUID()
    
    init(title: String) {
        self.title = title
    }
    
    static func sampleData() -> Array<Note> {
        return [
            Note(title: "Pack up for vacation"),
            Note(title: "Clean the kitchen")
        ]
    }
    
    // When can we consider two instances equal?
    // Ans: When their id's are the same
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
    
    // The correct value to hash is the "id", since it's the same we are using
    // on the "==" function. If we consider two Notes with the same UUID to be
    // equal, the Hash value that they will provide should be the same as well,
    // so we'll use the "id".
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
