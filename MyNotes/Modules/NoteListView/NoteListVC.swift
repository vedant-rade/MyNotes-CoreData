//
//  NoteListVC.swift
//  MyNotes
//
//  Created by apple on 06/07/25.
//

import UIKit

class NoteListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var noteLists: [NoteListModel] = []
    private let noteListManager = NoteListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.registerTableCell(identifier: "NoteListTVCell")
    }

    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func newListBtnActn(_ sender: Any) {
        self.showInputAlert(title: "Create new watchlist", message: "Enter name for you watchlist") { name in
            if let nameString = name {
                self.noteListManager.createNoteList(noteList: NoteListModel(id: UUID(), name: nameString, dateCreated: Date()))
                self.getData()
            }
        }
    }
}

extension NoteListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteListTVCell", for: indexPath) as? NoteListTVCell else { return UITableViewCell() }
        
        cell.configureData(title: noteLists[indexPath.row].name, index: indexPath.row)
        cell.delegate = self
        
        return cell
    }
}

extension NoteListVC: NoteListTVCellProtocol {
    func deleteList(indexPath: Int) {
        self.showConfirmationAlert(title: "Are you sure?", message: "You want to delete this note", cancelTitle: "No", confirmTitle: "Yes") {
            if self.noteListManager.deleteNoteList(id: self.noteLists[indexPath].id) {
                self.getData()
            } else {
                self.showAlert("Error", "Unable to delete note")
            }
        }
    }
}

extension NoteListVC {
    func getData() {
        noteLists.removeAll()
        if let data = noteListManager.fetchAllNoteLists() {
            noteLists = data
        }
        tableView.reloadData()
    }
}
