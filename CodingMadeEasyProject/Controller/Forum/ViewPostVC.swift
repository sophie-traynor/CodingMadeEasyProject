//
//  ViewPostVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 25/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseStorage

class ViewPostVC: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postTitleTextView: UILabel!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var post: Post?
    var user: String?
    var profileUrl: String?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            postTitleTextView.text = post.postTitle
            postDescriptionTextView.text = post.postDescription
        }
        username.text = user
        
        if profileUrl != "" {
            loadImage()
        }
        
    }

    //MARK: - Actions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToForum", sender: self)
    }

    func loadImage(){
        let profileStorageRef = Storage.storage().reference(forURL: profileUrl!)
        /// Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        profileStorageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                if let imageData = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.profileImage.image = image
                    }
                }
            }
        }
    }
    
}
