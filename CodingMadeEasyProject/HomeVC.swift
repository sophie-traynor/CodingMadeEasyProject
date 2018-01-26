//
//  HomeVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 25/10/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class HomeVC: UIViewController {
    
    //MARK: properties
    @IBOutlet weak var displayNameLabel: UILabel!

    var ref: DatabaseReference?
    var displayName: String = "No Name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        loadDisplayName()
        
    }
    
    func loadDisplayName(){
        let userID = Auth.auth().currentUser?.uid
        ref?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let displayName = value?["Display Name"] as? String ?? ""
            
            self.displayNameLabel.text = displayName
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
