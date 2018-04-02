//
//  WritePostVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 25/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class WritePostVC: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var postTitleTextView: UITextView!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    
    ///Reference to Firebase Database
    var ref: DatabaseReference?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
    }
    
    //Dismiss the keyboard when view is tapped on when in text views
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        postTitleTextView.resignFirstResponder()
        postDescriptionTextView.resignFirstResponder()
    }
    
    //MARK: - Actions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToForum", sender: self)
    }
    
    @IBAction func SubmitPostPressed(_ sender: UIButton) {
        if postTitleTextView.text!.isEmpty || postDescriptionTextView.text!.isEmpty{
            createAlert(title: "Error", message: "All Fields must contain values")
        }
        else{
            saveData()
            self.performSegue(withIdentifier: "unwindToForum", sender: self)
        }
    }
    
    //MARK: - Public Functions
    func saveData(){
        
        var username: String = ""
        var profileImageUrl: String = ""
        
        let userID = Auth.auth().currentUser?.uid
        ref?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
    
            username = value?["Display Name"] as? String ?? ""
            
            if snapshot.hasChild("ProfileURL"){
                profileImageUrl = value?["ProfileURL"] as? String ?? ""
                }
        })
        
        let postTitle = postTitleTextView.text
        let postDescription = postDescriptionTextView.text
        
        self.ref?.child("posts").childByAutoId().updateChildValues(["username": username,"profileImageUrl": profileImageUrl, "postTitle" : postTitle!, "postDescription" : postDescription!], withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
        })
        
    }
    
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
}