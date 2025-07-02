//
//  NoteVC.swift
//  MyNotes
//
//  Created by apple on 01/07/25.
//

import UIKit

class NoteVC: UIViewController {

    @IBOutlet weak var contentTv: UITextView!
    @IBOutlet weak var headingTf: UITextField!
    
    var isNewNote: Bool = true
    var noteData: NoteModel?
    private let manager = NoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupData()
        
    }
    
    @IBAction func saveNoteBtnActn(_ sender: UIButton) {
        if isNewNote {
            manager.createNote(note: NoteModel(heading: headingTf.text ?? "", content: contentTv.text ?? "", dateCreated: Date(), dateModified: Date(), id: UUID()))
        } else {
            if manager.updateNote(note: NoteModel(heading: headingTf.text ?? "", content: contentTv.text ?? "", dateCreated: noteData?.dateCreated, dateModified: Date(), id: noteData?.id ?? UUID())) {
            } else {
                self.showAlert("Error", "Unable to delete note")
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteNoteBtnActn(_ sender: UIButton) {
        self.showConfirmationAlert(title: "Are you sure?", message: "You want to delete this note", cancelTitle: "No", confirmTitle: "Yes") {
            if self.manager.deleteNote(id: self.noteData?.id ?? UUID()) {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showAlert("Error", "Unable to delete note")
            }
        }
    }
}

extension NoteVC {
    private func setupData() {
        self.headingTf.text = noteData?.heading
        self.contentTv.text = noteData?.content
    }
}
