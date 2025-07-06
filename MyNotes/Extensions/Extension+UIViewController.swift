//
//  Extension+UIViewController.swift
//  MyNotes
//
//  Created by apple on 24/06/25.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showConfirmationAlert(title: String, message: String, cancelTitle: String, confirmTitle: String, onComplete: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Cancel Action
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)

        // Complete Action
        let completeAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            onComplete() // closure call when complete is tapped
        }

        alert.addAction(cancelAction)
        alert.addAction(completeAction)

        present(alert, animated: true)
    }
    
    func showInputAlert(title: String, message: String, onComplete: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Add textfield
        alert.addTextField { textField in
            textField.placeholder = ""
        }

        // Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        // OK Action
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let text = alert.textFields?.first?.text
            onComplete(text)
        }

        alert.addAction(cancelAction)
        alert.addAction(okAction)

        present(alert, animated: true)
    }
}


