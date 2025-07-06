//
//  NoteRepository.swift
//  MyNotes
//
//  Created by apple on 01/07/25.
//

import Foundation
import CoreData

protocol NoteRepositoryProtocol: RepositoryProtocol {
    func getAllRecords(noteList: NoteListModel) -> [NoteModel]?
    
}

struct NoteRepository: NoteRepositoryProtocol {
    
    typealias T = NoteModel
    
    func createRecord(record: NoteModel) {
        let noteEntity = Note(context: PersistentStorage.shared.context)
        
        noteEntity.heading = record.heading
        noteEntity.content = record.content
        noteEntity.dateCreated = record.dateCreated
        noteEntity.dateModified = record.dateModified
        noteEntity.id = record.id
        
        noteEntity.noteList = NoteListRepository().getNoteList(id: record.noteList.id)
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAllRecords() -> [NoteModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Note.self)
        
        var notes: [NoteModel] = []
        
        result?.forEach({ noteEntity in
            notes.append(noteEntity.convertToNoteModel())
        })
        
        return notes
    }
    
    func getAllRecords(noteList: NoteListModel) -> [NoteModel]? {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        // ✅ Predicate to filter Notes by NoteList id
        fetchRequest.predicate = NSPredicate(format: "noteList.id == %@", noteList.id as CVarArg)
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            
            let notes = result.map { $0.convertToNoteModel() }
            return notes
        } catch {
            print("Failed to fetch notes for NoteList \(noteList.name): \(error)")
            return nil
        }
    }

    
    func deleteRecord(id: UUID) -> Bool {
        let noteEntity = getNote(id: id)
        guard noteEntity != nil else { return false }
        
        PersistentStorage.shared.context.delete(noteEntity!)
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func updateRecord(record: NoteModel) -> Bool {
        let noteEntity = getNote(id: record.id)
        guard noteEntity != nil else { return false }
        
        noteEntity?.heading = record.heading
        noteEntity?.content = record.content
        noteEntity?.dateCreated = record.dateCreated
        noteEntity?.dateModified = record.dateModified
        noteEntity?.id = record.id
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func getRecord(byIdentifier id: UUID) -> NoteModel? {
        let noteEntity = getNote(id: id)
        
        guard let data = noteEntity else { return nil }
        return data.convertToNoteModel()
    }
    
}

extension NoteRepository {
    private func getNote(id: UUID) -> Note? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        do {
            let noteEntity = try PersistentStorage.shared.context.fetch(fetchRequest).first as? Note
            
            guard noteEntity != nil else { return nil }
            return noteEntity
            
        } catch let error {
            print("Error in fetching Note by ID: \(error)")
        }
        
        return nil
    }
}

extension Note {
    func convertToNoteModel() -> NoteModel {
        return NoteModel(heading: self.heading ?? "", content: self.content ?? "", dateCreated: self.dateCreated ?? Date(), dateModified: self.dateModified ?? Date(), id: self.id ?? UUID(), noteList: self.noteList?.convertToNoteListModel() ?? NoteListModel(id: UUID(), name: "", dateCreated: Date()))
    }
}
