//
//  NotesTVCell.swift
//  MyNotes
//
//  Created by apple on 25/06/25.
//

import UIKit

protocol NotesTVCellProtocol: AnyObject {
    func deleteNote(indexPath: Int)
}

class NotesTVCell: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var indexPath: Int?
    
    weak var delegate: NotesTVCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteBtnActn(_ sender: UIButton) {
        if let index = indexPath {
            self.delegate?.deleteNote(indexPath: index)
        }
    }
    
    func setupUI() {
        mainView.roundCorners(radius: 15)
    }
    
    func configureData(data: NoteModel, indexPath: Int) {
        
        self.headingLbl.text = data.heading
        self.contentLbl.text = data.content
        self.indexPath = indexPath
    }
}
