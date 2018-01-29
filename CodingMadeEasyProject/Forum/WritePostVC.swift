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
        
        let postTitle = postTitleTextView.text
        let postDescription = postDescriptionTextView.text
        self.ref?.child("posts").childByAutoId().updateChildValues(["Post Title" : postTitle!, "Post Description" : postDescription!], withCompletionBlock: { (error, ref) in
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
