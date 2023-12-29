//
//  Notes.swift
//  DanielKeep
//
//  Created by Dani Benet on 27/12/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Note {

    var title: String
    var content: String
    var dueDate: Date?
    var noteColor: NoteColor
    
    init(
        title: String,
        content: String = "",
        dueDate: Date? = nil,
        bgColor: NoteColor = NoteColor.transparent
    ) {
        self.title = title
        self.content = content
        self.dueDate = dueDate
        self.noteColor = bgColor
    }
}
