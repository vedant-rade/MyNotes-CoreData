//
//  BaseRepo.swift
//  MyNotes
//
//  Created by apple on 05/07/25.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype T
    
    func createRecord(record: T)
    func getAllRecords() -> [T]?
    func deleteRecord(id: UUID) -> Bool
    func updateRecord(record: T) -> Bool
    func getRecord(byIdentifier id: UUID) -> T?
}
