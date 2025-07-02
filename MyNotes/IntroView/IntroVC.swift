//
//  IntroVC.swift
//  MyNotes
//
//  Created by apple on 02/07/25.
//

import UIKit

class IntroVC: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var nameTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameTf.delegate = self
        setupUI()
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        UserDefaultsManager.shared.setUsername(nameTf.text ?? "")
        self.pushMyNotesVC()
    }
    
    func setupUI() {
        nameTf.addDefaultDoneButton()
        continueBtn.addBorder(width: 1, color: .black, cornerRadius: 20)
    }
}

extension IntroVC: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        // Create the updated text manually
        if let currentText = textField.text,
           let textRange = Range(range, in: currentText) {
            
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)

            // Check length and enable/disable button
            continueBtn.isEnabled = updatedText.count > 2
            continueBtn.alpha = updatedText.count > 2 ? 1.0 : 0.5
        }

        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
