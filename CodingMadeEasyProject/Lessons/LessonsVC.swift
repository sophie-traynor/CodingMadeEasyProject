//
//  LessonsVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit

class LessonsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var lessons = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLessons()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    //MARK: Actions
    @IBAction func unwindToLessons(segue: UIStoryboardSegue) {
        
    }
    
    //MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LessonTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LessonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LessonTableViewCell.")
        }
        
        //Fetches the appropriate lesson for the data source layout.
        let lesson = lessons[indexPath.row]
        
        cell.lessonName.text = lesson.name
        cell.lessonDescription.text = lesson.description
        cell.lessonImage.image = lesson.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "ShowVisual", sender: self)
        case 1:
            performSegue(withIdentifier: "ShowAuditory", sender: self)
        case 2:
            performSegue(withIdentifier: "ShowReadWrite", sender: self)
        case 3:
            performSegue(withIdentifier: "ShowKinaesthetic", sender: self)
        default:
            fatalError("Unexpected Segue Identifier")
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowVisual":
            let destination = segue.destination as? VisualVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        case "ShowAuditory":
            let destination = segue.destination as? AuditoryVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        case "ShowReadWrite":
            let destination = segue.destination as? ReadWriteVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        case "ShowKinaesthetic":
            let destination = segue.destination as? KinaestheticVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Private methods
    private func loadLessons(){
        
        let photo = UIImage(named: "nophoto")
        
        guard let lesson1 = Lesson(name: "Lesson 1", description: "description", image: photo) else {
            fatalError("Unable to instantiate lesson1")
        }
        
        guard let lesson2 = Lesson(name: "Lesson 2", description: "description", image: photo) else {
            fatalError("Unable to instantiate lesson2")
        }
        
        guard let lesson3 = Lesson(name: "Lesson 3", description: "description", image: photo) else {
            fatalError("Unable to instantiate lesson2")
        }
        
        guard let lesson4 = Lesson(name: "Lesson 4", description: "description", image: photo) else {
            fatalError("Unable to instantiate lesson2")
        }
        
        lessons += [lesson1, lesson2, lesson3, lesson4]
    }

}
