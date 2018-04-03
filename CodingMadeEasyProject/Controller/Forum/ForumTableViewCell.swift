//
//  ForumTableViewCell.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 22/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class ForumTableViewCell: UITableViewCell {

    
    //MARK: - Properties
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    //MARK: - override Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
