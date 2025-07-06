//
//  NoteListTVCell.swift
//  MyNotes
//
//  Created by apple on 06/07/25.
//

import UIKit

protocol NoteListTVCellProtocol: AnyObject {
    func deleteList(indexPath: Int)
}

class NoteListTVCell: UITableViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var noteListLbl: UILabel!
    
    weak var delegate: NoteListTVCellProtocol?
    
    var indexPath: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteBtnActn(_ sender: Any) {
        if let index = indexPath {
            self.delegate?.deleteList(indexPath: index)
        }
    }
    
    private func setupUI() {
        bgView.roundCorners(radius: 10)
    }
    
    func configureData(title: String, index: Int) {
        self.noteListLbl.text = title
        self.indexPath = index
//        self.deleteBtn.isHidden = index == 0
    }
}
