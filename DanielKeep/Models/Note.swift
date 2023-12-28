//
//  Notes.swift
//  DanielKeep
//
//  Created by Dani Benet on 27/12/23.
//

import Foundation
import SwiftData

@Model
class Note {

    var title: String
    var content: String
    var dueDate: Date?
    
    init(title: String, content: String = "", dueDate: Date? = nil) {
        self.title = title
        self.content = content
        self.dueDate = dueDate
    }
}
