//
//  ViewPostVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 25/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ViewPostVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postTitleTextView: UILabel!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeCommentStackView: UIStackView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentsStackView: UIStackView!
    var ref: DatabaseReference?
    ///store comments
    var comments = [Comment]()
    var post: Post?
    var user: String?
    var profileUrl: String?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsStackView.isHidden = false
        writeCommentStackView.isHidden = true
        
        if let post = post {
            postTitleTextView.text = post.postTitle
            postDescriptionTextView.text = post.postDescription
        }
        username.text = user
        
        if profileUrl != "" {
            loadImage()
        }
        
        loadSampleComments()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    //MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PostComments"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ViewPostCommentsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ViewPostCommentsTableViewCell.")
        }
        
        let comment = comments[indexPath.row]
        
        cell.username.text = comment.username
        cell.userComment.text = comment.comment
        cell.userImg.image = comment.profileImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
    
    //MARK: - Private Functions
    func loadImage(){
        let profileStorageRef = Storage.storage().reference(forURL: profileUrl!)
        ///Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
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
    
    func loadSampleComments(){
        
        let photo1 = UIImage(named: "photo1")
        let photo2 = UIImage(named: "photo2")
        let photo3 = UIImage(named: "photo3")
        
        guard let comment1 = Comment(commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, massa id consequat rhoncus, odio eros feugiat elit, a vehicula nibh orci et nulla.", usernameText: "Jake", profileImg: photo1) else {
            fatalError("Unable to instantiate photo1")
        }
        
        guard let comment2 = Comment(commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, massa id consequat rhoncus, odio eros feugiat elit, a vehicula nibh orci et nulla.", usernameText: "James", profileImg: photo2) else {
            fatalError("Unable to instantiate photo2")
        }
        
        guard let comment3 = Comment(commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, massa id consequat rhoncus, odio eros feugiat elit, a vehicula nibh orci et nulla.", usernameText: "Joe", profileImg: photo3) else {
            fatalError("Unable to instantiate photo3")
        }
        
        comments += [comment1, comment2, comment3]
    }
    
    //MARK: - Actions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToForum", sender: self)
    }

    @IBAction func writeCommentBtnTapped(_ sender: UIButton) {
        commentsStackView.isHidden = true
        writeCommentStackView.isHidden = false
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        commentsStackView.isHidden = false
        writeCommentStackView.isHidden = true
    }
    
    @IBAction func postCommentBtnTapped(_ sender: UIButton) {
    }
    
}

