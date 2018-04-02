//
//  ForumVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
                let post = Post(postDescriptionText: postDescriptionText, postTitleText: postTitletext)
                self.posts.append(post)
                print(self.posts)
                self.tableView.reloadData()
            }
        }
    }

}
