//
//  MyNotesVC.swift
//  MyNotes
//
//  Created by apple on 25/06/25.
//

import UIKit

class MyNotesVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newNoteBtn: UIButton!
    @IBOutlet weak var greetingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var currentList = 0
    
    private var noteData: [NoteModel] = []
    private var noteListData: [NoteListModel] = []
    private let noteManager = NoteManager()
    private let noteListManager = NoteListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.registerTableCell(identifier: "NotesTVCell")
        collectionView.registerCollectCell(identifier: "NoteListCollectionCell")
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    @IBAction func editListsBtnActn(_ sender: UIButton) {
        self.pushToNoteListVC(noteLists: self.noteListData)
    }
    
    @IBAction func newListBtnActn(_ sender: Any) {
        self.showInputAlert(title: "Create new watchlist", message: "Enter name for you watchlist") { name in
            if let nameString = name {
                self.noteListManager.createNoteList(noteList: NoteListModel(id: UUID(), name: nameString, dateCreated: Date()))
                self.getData()
            }
        }
    }
    
    @IBAction func newNoteBtnActn(_ sender: Any) {
        self.pushNoteVC(isNewNote: true, noteList: noteListData[currentList])
    }
    
    func setupUI() {
        greetingLbl.text = "Hello, \(UserDefaultsManager.shared.getUsername() ?? "User")"
        newNoteBtn.addBorder(width: 1, color: .black, cornerRadius: 20)
    }
    
}

// MARK: TableView Manager
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
            if self.noteManager.deleteNote(id: self.noteData[indexPath].id) {
                self.getData()
            } else {
                self.showAlert("Error", "Unable to delete note")
            }
        }
    }
}

// MARK: CollectionView Manager
extension MyNotesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noteListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteListCollectionCell", for: indexPath) as? NoteListCollectionCell else { return UICollectionViewCell() }
        
        cell.configureData(title: noteListData[indexPath.row].name, isCurrentIndex: currentList == indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentList = indexPath.row
        self.getData()
    }
}

// MARK: API Call
extension MyNotesVC {
    private func getData() {
        noteListData.removeAll()
        noteData.removeAll()
        
        if let data = noteListManager.fetchAllNoteLists() {
            noteListData = data
        }
        
        currentList = noteListData.count > currentList ? currentList : 0
        
        if !noteListData.isEmpty {
            if currentList == 0 {
                if let data = noteManager.fetchAllNotes(noteList: nil) {
                    noteData = data
                }
            } else {
                if let data = noteManager.fetchAllNotes(noteList: noteListData[currentList]) {
                    noteData = data
                }
            }
        }
        
        collectionView.reloadData()
        tableView.reloadData()
    }
}
