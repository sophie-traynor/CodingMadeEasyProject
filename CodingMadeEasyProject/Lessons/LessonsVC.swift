//
//  LessonsVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit

class LessonsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var lessons = [Lesson]()
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLessons()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = 90.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    //MARK: - Actions
    @IBAction func unwindToLessons(segue: UIStoryboardSegue) {
        
    }
    
    //MARK: - Table View
    
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
        cell.lessonImage.image = lesson.cellImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowLesson", sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let destination = segue.destination as? IndividualLessonsVC
        let cellIndex = tableView.indexPathForSelectedRow?.row
        
        destination?.lesson = lessons[cellIndex!]
    }
    
    //MARK: - Private Functions
    private func loadLessons(){
        
        //let photo = UIImage(named: "nophoto")
        
        let photoCpp = UIImage(named: "cpp")
        let samplePhoto = UIImage(named: "sample")
        
        guard let lesson1 = Lesson(name: "Lesson 1",
                                   overview: "Learn the structure of a program",
                                   lessonDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   audioImage: samplePhoto,
                                   videoName: "sampleVideo",
                                   videoThumbnail: samplePhoto,
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson1")
        }
        
        guard let lesson2 = Lesson(name: "Lesson 2",
                                   overview: "Variables and data types",
                                   lessonDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   audioImage: samplePhoto,
                                   videoName: "sampleVideo",
                                   videoThumbnail: samplePhoto,
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson2")
        }
        
        guard let lesson3 = Lesson(name: "Lesson 3",
                                   overview: "Print a message to the screen",
                                   lessonDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   audioImage: samplePhoto,
                                   videoName: "sampleVideo",
                                   videoThumbnail: samplePhoto,
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson3")
        }
        
        guard let lesson4 = Lesson(name: "Lesson 4",
                                   overview: "Allow user input in a simple program",
                                   lessonDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   audioImage: samplePhoto,
                                   videoName: "sampleVideo",
                                   videoThumbnail: samplePhoto,
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson4")
        }
        
        guard let lesson5 = Lesson(name: "Lesson 5",
                                   overview: "Arrays",
                                   lessonDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   audioImage: samplePhoto,
                                   videoName: "sampleVideo",
                                   videoThumbnail: samplePhoto,
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson5")
        }
        
        lessons += [lesson1, lesson2, lesson3, lesson4, lesson5]
    }

}
