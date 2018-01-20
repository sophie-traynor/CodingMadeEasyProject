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
        cell.lessonOverview.text = lesson.overview
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
        
        guard let lesson1 = Lesson(name: "Lesson 1",
                                   overview: "overview",
                                   visualDescription: "lesson 1 visual description",
                                   auditoryDescription: "lesson 1 auditory description",
                                   readWriteDescription: "lesson 1 readWrite description",
                                   kinaestheticDescription: "lesson 1 kinaesthetic description",
                                   image: photo) else {
            fatalError("Unable to instantiate lesson1")
        }
        
        guard let lesson2 = Lesson(name: "Lesson 2",
                                   overview: "overview",
                                   visualDescription: "lesson 2 visual description",
                                   auditoryDescription: "lesson 2 auditory description",
                                   readWriteDescription: "lesson 2 readWrite description",
                                   kinaestheticDescription: "lesson 2 kinaesthetic description",
                                   image: photo) else {
            fatalError("Unable to instantiate lesson2")
        }
        
        guard let lesson3 = Lesson(name: "Lesson 3",
                                   overview: "overview",
                                   visualDescription: "lesson 3 visual description",
                                   auditoryDescription: "lesson 3 auditory description",
                                   readWriteDescription: "lesson 3 readWrite description",
                                   kinaestheticDescription: "lesson 3 kinaesthetic description",
                                   image: photo) else {
            fatalError("Unable to instantiate lesson3")
        }
        
        guard let lesson4 = Lesson(name: "Lesson 4",
                                   overview: "overview",
                                   visualDescription: "lesson 4 visual description",
                                   auditoryDescription: "lesson 4 auditory description",
                                   readWriteDescription: "lesson 4 readWrite description",
                                   kinaestheticDescription: "lesson 4 kinaesthetic description",
                                   image: photo) else {
            fatalError("Unable to instantiate lesson4")
        }
        
        guard let lesson5 = Lesson(name: "Lesson 5",
                                   overview: "overview",
                                   visualDescription: "lesson 5 visual description",
                                   auditoryDescription: "lesson 5 auditory description",
                                   readWriteDescription: "lesson 5 readWrite description",
                                   kinaestheticDescription: "lesson 5 kinaesthetic description",
                                   image: photo) else {
            fatalError("Unable to instantiate lesson5")
        }
        
        lessons += [lesson1, lesson2, lesson3, lesson4, lesson5]
    }

}
