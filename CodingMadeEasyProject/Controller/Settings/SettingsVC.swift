//
//  SettingsVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsVC: UIViewController {
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Public Functions
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        ///creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @IBAction func unwindToSettings(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func contactBtnPressed(_ sender: UIButton) {
        createAlert(title: "Contact Details", message: "Email: codingMadeEasy@email.com")
        
    }
    
    @IBAction func SignOut (_sender: UIButton){
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            print("Successfully signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

        ///dismiss home view controller
        self.dismiss(animated: true, completion: {});
        self.navigationController?.popViewController(animated: true);
    }
}
