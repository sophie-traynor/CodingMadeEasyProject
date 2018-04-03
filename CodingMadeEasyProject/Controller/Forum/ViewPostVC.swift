//
//  ViewPostVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 25/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class ViewPostVC: UIViewController {

    @IBOutlet weak var postTitleTextView: UILabel!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    
    var post: Post?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            postTitleTextView.text = post.postTitle
            postDescriptionTextView.text = post.postDescription
        }
        
    }

    //MARK: - Actions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToForum", sender: self)
    }

}
