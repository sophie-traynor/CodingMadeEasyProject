//
//  LessonTableViewDelegate.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 14/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LessonTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LessonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LessonTableViewCell.")
        }
        
        // Fetches the appropriate lesson for the data source layout.
        let lesson = lessons[indexPath.row]
        
        cell.lessonNameLabel.text = lesson.name
        cell.lessonImageView.image = lesson.image
        
        return cell
    }
}
