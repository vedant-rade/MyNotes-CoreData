//
//  ViewController.swift
//  MyNotes
//
//  Created by apple on 23/06/25.
//

import UIKit
import CoreData

class InitialVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        moveToNextPage()
    }
    
    private func moveToNextPage() {
        if let _ = UserDefaultsManager.shared.getUsername() {
            self.pushMyNotesVC()
        } else {
            self.pushIntroVC()
        }
    }
}

