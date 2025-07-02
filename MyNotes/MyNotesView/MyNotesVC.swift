//
//  MyNotesVC.swift
//  MyNotes
//
//  Created by apple on 25/06/25.
//

import UIKit

class MyNotesVC: UIViewController {

    @IBOutlet weak var newNoteBtn: UIButton!
    @IBOutlet weak var greetingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var noteData: [NoteModel] = []
    private let manager = NoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.registerTableCell(identifier: "NotesTVCell")
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    @IBAction func newNoteBtnActn(_ sender: Any) {
        self.pushNoteVC(isNewNote: true)
    }
    
    func setupUI() {
        greetingLbl.text = "Hello, \(UserDefaultsManager.shared.getUsername() ?? "User")"
        newNoteBtn.addBorder(width: 1, color: .black, cornerRadius: 20)
    }
    
}

extension MyNotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTVCell", for: indexPath) as? NotesTVCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.configureData(data: noteData[indexPath.row], indexPath: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushNoteVC(isNewNote: false, noteData: noteData[indexPath.row])
    }
}

extension MyNotesVC: NotesTVCellProtocol {
    func deleteNote(indexPath: Int) {
        self.showConfirmationAlert(title: "Are you sure?", message: "You want to delete this note", cancelTitle: "No", confirmTitle: "Yes") {
            if self.manager.deleteNote(id: self.noteData[indexPath].id) {
                self.getData()
            } else {
                self.showAlert("Error", "Unable to delete note")
            }
        }
    }
}

extension MyNotesVC {
    private func getData() {
        if let data = manager.fetchAllNotes() {
            noteData = data
        }
        
        tableView.reloadData()
    }
}
