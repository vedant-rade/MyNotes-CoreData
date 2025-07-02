//
//  NoteManager.swift
//  MyNotes
//
//  Created by apple on 02/07/25.
//

import Foundation

struct NoteManager {
    private let noteRepo = NoteRepository()
    
    func createNote(note: NoteModel) {
        noteRepo.createNote(note: note)
    }
    
    func fetchAllNotes() -> [NoteModel]? {
        return noteRepo.getAllNotes()
    }
    
    func deleteNote(id: UUID) -> Bool {
        return noteRepo.deleteNote(id: id)
    }
    
    func updateNote(note: NoteModel) -> Bool {
        return noteRepo.updateNote(note: note)
    }
    
    func fetchNote(byIdentifier id: UUID) -> NoteModel? {
        return noteRepo.getNote(byIdentifier: id)
    }
}
