//
//  NoteListCollectionCell.swift
//  MyNotes
//
//  Created by apple on 05/07/25.
//

import UIKit

class NoteListCollectionCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var noteListTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        bgView.roundCorners(radius: 10)
    }
    
    func configureData(title: String, isCurrentIndex: Bool) {
        noteListTitle.text = title
        bgView.backgroundColor = isCurrentIndex == true ? .green : .systemGray4
    }

}
