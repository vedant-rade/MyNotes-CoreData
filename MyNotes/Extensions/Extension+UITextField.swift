//
//  Extension+UITextField.swift
//  MyNotes
//
//  Created by apple on 24/06/25.
//

import UIKit

extension UITextField {
    func addDefaultDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))

        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }

    @objc private func dismissKeyboard() {
        self.resignFirstResponder()
    }
}
