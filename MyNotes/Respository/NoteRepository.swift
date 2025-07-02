//
//  NoteRepository.swift
//  MyNotes
//
//  Created by apple on 01/07/25.
//

import Foundation
import CoreData

protocol NoteRepositoryProtocol {
    func createNote(note: NoteModel)
    func getAllNotes() -> [NoteModel]?
    func deleteNote(id: UUID) -> Bool
    func updateNote(note: NoteModel) -> Bool
    func getNote(byIdentifier id: UUID) -> NoteModel?
}

struct NoteRepository: NoteRepositoryProtocol {
    
    func createNote(note: NoteModel) {
        let noteEntity = Note(context: PersistentStorage.shared.context)
        
        noteEntity.heading = note.heading
        noteEntity.content = note.content
        noteEntity.dateCreated = note.dateCreated
        noteEntity.dateModified = note.dateModified
        noteEntity.id = note.id
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAllNotes() -> [NoteModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Note.self)
        
        var notes: [NoteModel] = []
        
        result?.forEach({ noteEntity in
            notes.append(noteEntity.convertToNoteModel())
        })
        
        return notes
    }
    
    func deleteNote(id: UUID) -> Bool {
        let noteEntity = getNote(id: id)
        guard noteEntity != nil else { return false }
        
        PersistentStorage.shared.context.delete(noteEntity!)
        
        return true
    }
    
    func updateNote(note: NoteModel) -> Bool {
        let noteEntity = getNote(id: note.id)
        guard noteEntity != nil else { return false }
        
        noteEntity?.heading = note.heading
        noteEntity?.content = note.content
        noteEntity?.dateCreated = note.dateCreated
        noteEntity?.dateModified = note.dateModified
        noteEntity?.id = note.id
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func getNote(byIdentifier id: UUID) -> NoteModel? {
        let noteEntity = getNote(id: id)
        
        guard noteEntity != nil else { return nil }
        return noteEntity?.convertToNoteModel()
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
        return NoteModel(heading: self.heading ?? "", content: self.content ?? "", dateCreated: self.dateCreated ?? Date(), dateModified: self.dateModified ?? Date(), id: self.id ?? UUID())
    }
}
