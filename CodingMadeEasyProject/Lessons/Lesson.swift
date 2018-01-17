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
    var description: String
    var image: UIImage?
    
    struct PropertyKey{
        static let name = "name"
        static let description = "description"
        static let image = "image"
    }
    
    init?(name: String, description: String, image: UIImage?) {
        self.name = name
        self.description = description
        self.image = image
    }
}

