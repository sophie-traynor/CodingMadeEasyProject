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

class WritePostVC: UIViewController, UITextViewDelegate {

    //MARK: - Properties
    @IBOutlet weak var postTitleTextView: UITextView!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    ///Reference to Firebase Database
    var ref: DatabaseReference?
    var username: String = ""
    var profileImageUrl: String = ""
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        postTitleTextView.delegate = self
        postDescriptionTextView.delegate = self
        setUpToolbar()
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
    func setUpToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem
            .done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([doneButton], animated: false)
        
        postTitleTextView.inputAccessoryView = toolbar
        postDescriptionTextView.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked()
    {
        view.endEditing(true)
    }
    
    func saveData(){
        ///get current username and profile url
        self.username = userInfo.displayName
        self.profileImageUrl = userInfo.profileImageUrl
        
        let postTitle = postTitleTextView.text
        let postDescription = postDescriptionTextView.text
        ///store post info to firebase under posts
        self.ref?.child("posts").childByAutoId().updateChildValues(["username": self.username,"profileImageUrl": self.profileImageUrl, "postTitle" : postTitle!, "postDescription" : postDescription!], withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
            print("Successfully saved forum post to firebase database")
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
