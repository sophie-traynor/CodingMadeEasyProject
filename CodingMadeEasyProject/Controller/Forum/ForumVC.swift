//
//  ForumVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ForumVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
     ///Reference to Firebase Database
    var ref: DatabaseReference?
    ///Array to store the forum posts
    //var posts = [String]()
    
    var posts = [Post]()
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
        listenForPosts()
        
        //var post = Post(postDescriptionText: "test.....", postTitleText: "rtdhfartdfhber")
        //print(post.postDescription)
        //print(post.postTitle)
    }
    
    //Dismiss the keyboard when view is tapped on 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ForumTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ForumTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ForumTableViewCell.")
        }
        
        cell.questionLabel.text = posts[indexPath.row].postTitle
        cell.usernameLabel.text = posts[indexPath.row].username
    
        if posts[indexPath.row].profileImageUrl != "" {
            let profileStorageRef = Storage.storage().reference(forURL: posts[indexPath.row].profileImageUrl)
            /// Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            profileStorageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    if let imageData = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData)
                            cell.profileImageView.image = image
                        }
                    }
                }
            }
        } else {
            print("no profile image for row", indexPath.row)
        }
        
        
        return cell
    }
  
    
    //MARK: - Actions
    
    @IBAction func unwindToForum(segue: UIStoryboardSegue) {
        
    }
    
    //MARK: - Public Functions
    
    
    ///Checks firebase database for forum posts
    func listenForPosts(){
        
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let postDescriptionText = dict["postDescription"] as! String
                let postTitletext = dict["postTitle"] as! String
                let usernameText = dict["username"] as! String
                let profileImageLink = dict["profileImageUrl"] as! String
                let post = Post(postDescriptionText: postDescriptionText, usernameText: usernameText, postTitleText: postTitletext, profileImageLink: profileImageLink)
                //self.posts.append(post)
                self.posts.insert(post, at: 0)
                
                print(dict)
                self.tableView.reloadData()
            }
        }
    }

}