//
//  Coordinator.swift
//  MyNotes
//
//  Created by apple on 25/06/25.
//

import UIKit

extension UIViewController {
    func pushIntroVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let introVC = storyboard.instantiateViewController(withIdentifier: "IntroVC") as? IntroVC {
            self.navigationController?.pushViewController(introVC, animated: true)
        }
    }
    
    func pushMyNotesVC() {
        let storyboard = UIStoryboard(name: "Notes", bundle: nil)
        if let myNotesVC = storyboard.instantiateViewController(withIdentifier: "MyNotesVC") as? MyNotesVC {
            self.navigationController?.pushViewController(myNotesVC, animated: true)
        }
    }
    
    func pushNoteVC(isNewNote: Bool, noteData: NoteModel? = nil) {
        let storyboard = UIStoryboard(name: "Notes", bundle: nil)
        if let noteVC = storyboard.instantiateViewController(withIdentifier: "NoteVC") as? NoteVC {
            noteVC.noteData = noteData
            noteVC.isNewNote = isNewNote
            self.navigationController?.pushViewController(noteVC, animated: true)
        }
    }
}
