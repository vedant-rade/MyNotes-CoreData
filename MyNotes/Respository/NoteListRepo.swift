//
//  NoteListRepo.swift
//  MyNotes
//
//  Created by apple on 05/07/25.
//

import Foundation
import CoreData

protocol NoteListRepositoryProtocol: RepositoryProtocol {}

struct NoteListRepository: NoteListRepositoryProtocol {
    typealias T = NoteListModel
    
    func createRecord(record: NoteListModel) {
        let noteListEntity = NoteList(context: PersistentStorage.shared.context)
        
        noteListEntity.id = record.id
        noteListEntity.dateCreated = record.dateCreated
        noteListEntity.name = record.name
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAllRecords() -> [NoteListModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: NoteList.self)
        
        var noteLists: [NoteListModel] = []
        
        result?.forEach({ noteListEntity in
            noteLists.append(noteListEntity.convertToNoteListModel())
        })
        
        return noteLists
    }
    
    func updateRecord(record: NoteListModel) -> Bool {
        let noteListEntity = getNoteList(id: record.id)
        guard noteListEntity != nil else { return false }
        
        noteListEntity?.id = record.id
        noteListEntity?.dateCreated = record.dateCreated
        noteListEntity?.name = record.name
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func getRecord(byIdentifier id: UUID) -> NoteListModel? {
        let noteListEntity = getNoteList(id: id)
        
        guard noteListEntity != nil else { return nil }
        return noteListEntity?.convertToNoteListModel()
    }
    
    func deleteRecord(id: UUID) -> Bool {
        let noteListEntity = getNoteList(id: id)
        guard noteListEntity != nil else { return false }
        
        PersistentStorage.shared.context.delete(noteListEntity!)
        PersistentStorage.shared.saveContext()
        
        return true
    }
}

extension NoteListRepository {
    func getNoteList(id: UUID) -> NoteList? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteList")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        do {
            let noteListEntity = try PersistentStorage.shared.context.fetch(fetchRequest).first as? NoteList
            
            guard noteListEntity != nil else { return nil }
            return noteListEntity
            
        } catch let error {
            print("Error in fetching Note by ID: \(error)")
        }
        
        return nil
    }
}

extension NoteList {
    func convertToNoteListModel() -> NoteListModel {
        return NoteListModel(id: self.id ?? UUID(), name: self.name ?? "", dateCreated: self.dateCreated ?? Date())
    }
}
