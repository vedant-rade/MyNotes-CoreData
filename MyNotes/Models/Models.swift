//
//  Models.swift
//  MyNotes
//
//  Created by apple on 02/07/25.
//

import Foundation

struct NoteModel {
    let heading: String?
    let content: String?
    let dateCreated: Date?
    let dateModified: Date?
    let id: UUID
    let noteList: NoteListModel
}

struct NoteListModel {
    let id: UUID
    let name: String
    let dateCreated: Date
}
