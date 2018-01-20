//
//  Lesson.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 16/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class Lesson {
    
    //MARK: Properties
    var name: String
    var overview: String
    var visualDescription: String
    var auditoryDescription: String
    var readWriteDescription: String
    var kinaestheticDescription: String
    var image: UIImage?
    
    struct PropertyKey{
        static let name = "name"
        static let overview = "overview"
        static let visualDescription = "visualDescription"
        static let auditoryDescription = "auditoryDescription"
        static let readWriteDescription = "readWriteDescription"
        static let kinaestheticDescription = "kinaestheticDescription"
        static let image = "image"
    }
    
    init?(name: String, overview: String, visualDescription: String, auditoryDescription: String, readWriteDescription: String, kinaestheticDescription: String, image: UIImage?) {
        self.name = name
        self.overview = overview
        self.visualDescription = visualDescription
        self.auditoryDescription = auditoryDescription
        self.readWriteDescription = readWriteDescription
        self.kinaestheticDescription = kinaestheticDescription
        self.image = image
    }
}

