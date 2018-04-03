//
//  FeedbackVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FeedbackVC: UIViewController {

    @IBOutlet weak var feedbackTextView: UITextView!
    
    ///Reference to Firebase Database
    var ref: DatabaseReference?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
        setUpToolbar()
    }
    
    //Dismiss the keyboard when view is tapped on when in email or password text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        feedbackTextView.resignFirstResponder()
        
    }
    
    //MARK: - Actions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToSettings", sender: self)
    }
    
    @IBAction func submitFeedbackPressed(_ sender: UIButton) {
        if feedbackTextView.text.isEmpty{
            createAlert(title: "Error", message: "No Feedback entered")
        }
        else{
            saveData()
            self.performSegue(withIdentifier: "unwindToSettings", sender: self)
        }
        
    }
    
    //MARK: - Public Functions
    func saveData(){
        
        let feedback = feedbackTextView.text
        self.ref?.child("user feedback").childByAutoId().updateChildValues(["feedback" : feedback!], withCompletionBlock: { (error, ref) in
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
    
    func setUpToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem
            .done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([doneButton], animated: false)
        
        feedbackTextView.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked()
    {
        view.endEditing(true)
    }
    
}
