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
    
    var ref: DatabaseReference?
    var posts = [String]()
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        return cell
    }
  
    
    //MARK: - Actions
    
    @IBAction func unwindToForum(segue: UIStoryboardSegue) {
        
    }
    
    //MARK: - Public Functions
    func listenForPosts(){
        ref?.child("posts").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            
            if let actualPost = post {
                self.posts.append(actualPost)
                self.tableView.reloadData()
            }
        })
    }

}
