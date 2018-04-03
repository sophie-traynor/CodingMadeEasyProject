//
//  User.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 02/04/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class User {
    var displayName: String
    var profileImageUrl: String?
    
    init(display: String, profile: String) {
        self.displayName = display
        self.profileImageUrl = profile
    }
}
