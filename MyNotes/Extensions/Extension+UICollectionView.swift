//
//  Extension+UICollectionView.swift
//  MyNotes
//
//  Created by apple on 05/07/25.
//

import UIKit

extension UICollectionView {
    func registerCollectCell(identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}
