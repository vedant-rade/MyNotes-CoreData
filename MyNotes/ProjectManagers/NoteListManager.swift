//
//  NoteListManager.swift
//  MyNotes
//
//  Created by apple on 05/07/25.
//

import Foundation

struct NoteListManager {
    private let noteListRepo = NoteListRepository()
    
    func createNoteList(noteList: NoteListModel) {
        noteListRepo.createRecord(record: noteList)
    }
    
    func fetchAllNoteLists() -> [NoteListModel]? {
        return noteListRepo.getAllRecords()
    }
    
    func deleteNoteList(id: UUID) -> Bool {
        return noteListRepo.deleteRecord(id: id)
    }
    
    func updateNoteList(noteList: NoteListModel) -> Bool {
        return noteListRepo.updateRecord(record: noteList)
    }
    
    func fetchNoteList(byIdentifier id: UUID) -> NoteListModel? {
        return noteListRepo.getRecord(byIdentifier: id)
    }
}
