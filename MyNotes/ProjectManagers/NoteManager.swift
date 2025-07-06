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
        noteRepo.createRecord(record: note)
    }
    
    func fetchAllNotes(noteList: NoteListModel?) -> [NoteModel]? {
        if let list = noteList {
            return noteRepo.getAllRecords(noteList: list)
        }
        return noteRepo.getAllRecords()
    }
    
    func deleteNote(id: UUID) -> Bool {
        return noteRepo.deleteRecord(id: id)
    }
    
    func updateNote(note: NoteModel) -> Bool {
        return noteRepo.updateRecord(record: note)
    }
    
    func fetchNote(byIdentifier id: UUID) -> NoteModel? {
        return noteRepo.getRecord(byIdentifier: id)
    }
}
