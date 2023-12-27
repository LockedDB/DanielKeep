//
//  List.swift
//  DanielKeep
//
//  Created by Dani Benet on 26/12/23.
//

import Foundation

struct NotesList: Identifiable, Hashable {
    var name: String
    var id = UUID()
    
    static func sampleData() -> Array<NotesList> {
        return [
            NotesList(name: "My Notes"),
            NotesList(name: "My Bento Box")
        ]
    }
}
