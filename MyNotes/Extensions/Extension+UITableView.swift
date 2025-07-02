//
//  Extension+UITableView.swift
//  MyNotes
//
//  Created by apple on 25/06/25.
//

import UIKit

extension UITableView {
    func registerTableCell(identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
