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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let destination = segue.destination as? IndividualLessonsVC
        let cellIndex = tableView.indexPathForSelectedRow?.row
        
        destination?.lesson = lessons[cellIndex!]
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "LessonTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LessonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LessonTableViewCell.")
        }
        
        ///Fetches the appropriate lesson for the data source layout.
        let lesson = lessons[indexPath.row]
        
        cell.lessonName.text = lesson.name
        cell.lessonOverview.text = lesson.overview
        cell.lessonImage.image = lesson.cellImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowLesson", sender: self)
    }
    
    //MARK: - Private Functions
    private func loadLessons(){
        
        let photoCpp = UIImage(named: "cpp")
        
        guard let lesson1 = Lesson(name: "Lesson 1",
                                   overview: "Print a message to the screen",
                                   lessonDescription: "Learn how to print Hello World to the screen",
                                   readText: """
                                                        Welcome to your first C++ lesson!
                                                        Today we will learn how to print Hello World to the screen.

                                                        • cout - This is a standard output stream which allows us to print to the screen.
                                                        • << - This is the insert operator which follows directly after cout to specify the data we are sending to the stream.
                                                        • "..." - We put the text within quotation marks after the insertion operator. This will be the message printed to the screen. We can also directly specify a variable name which we will look at in the next lesson.
                                                        • endl - Following the quotation, we should include another insert operator to specify the endl. endl will end the current line so if another cout occurs, it will start on a new line.
                                                        • ; - Each line of code should always end in a semicolon, this is to confirm we have finished the line of code.
                                                        
                                                        Example:
                                                        cout << "Hello World" << endl;
                                                        """,
                                   audioName: "lesson1",
                                   videoName: "lesson1",
                                   cellImage: photoCpp,
                                   answer: "cout << \"Hello World\" << endl;",
                                   output: """
                                            Hello World
                                            """)
                                   else {
            fatalError("Unable to instantiate lesson2")
        }
        
        guard let lesson2 = Lesson(name: "Lesson 2",
                                   overview: "Variables and data types",
                                   lessonDescription: "Learn all about variables and different data types!",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   videoName: "sampleVideo",
                                   cellImage: photoCpp,
                                   answer: """
                                            int first = 1;
                                            float second = 4.76;
                                            cout << first << endl;
                                            cout << second << endl;
                                            """,
                                   output: """
                                            first = 1
                                            second = 4.76
                                            """)
                                   else {
            fatalError("Unable to instantiate lesson3")
        }
        
        guard let lesson3 = Lesson(name: "Lesson 3",
                                   overview: "Allow user input in a simple program",
                                   lessonDescription: "Learn how to request user input from a program!",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   videoName: "sampleVideo",
                                   cellImage: photoCpp,
                                   answer: ".......",
                                   output: """
                                            .......
                                            """)
                                   else {
            fatalError("Unable to instantiate lesson4")
        }
        
        guard let lesson4 = Lesson(name: "Lesson 4",
                                   overview: "Arrays",
                                   lessonDescription: "Learn how to use Arrays!",
                                   readText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mattis odio a lacus vulputate placerat eu sed augue. Aliquam dui neque, volutpat et metus quis, condimentum bibendum dolor. Phasellus magna metus, accumsan eget lectus sit amet, suscipit varius turpis. Praesent in ante scelerisque, mattis tortor id, viverra libero. Sed facilisis consequat iaculis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ornare velit ac leo commodo ultrices. Ut laoreet volutpat nisi, rhoncus ultricies arcu eleifend sit amet. Pellentesque congue semper lorem, nec sagittis libero fringilla at. Pellentesque feugiat sapien sit amet eros rutrum efficitur. Donec sit amet magna elit. Cras ornare ligula a magna bibendum, in molestie enim ullamcorper. Donec rhoncus sollicitudin sem, non fringilla nibh rutrum ut. Donec malesuada, felis ac vestibulum tristique, sem ipsum euismod massa, vel rutrum tortor libero sed felis. Nullam sodales aliquam mauris non facilisis. Curabitur iaculis nunc quis ligula malesuada, non facilisis lorem luctus. Suspendisse sed cursus purus, ac elementum est. Duis luctus ex at commodo blandit. Suspendisse potenti. Curabitur semper posuere nisl nec finibus. Nam at facilisis sapien, a bibendum est. Fusce facilisis lobortis urna, id auctor diam sagittis mattis.",
                                   audioName: "sampleAudio",
                                   videoName: "sampleVideo",
                                   cellImage: photoCpp,
                                   answer: ".......",
                                   output: """
                                            ......
                                            """)
                                   else {
            fatalError("Unable to instantiate lesson5")
        }
        
        lessons += [lesson1, lesson2, lesson3, lesson4]
    }

    //MARK: - Actions
    @IBAction func unwindToLessons(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
}
