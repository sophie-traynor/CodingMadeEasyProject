//
//  ViewPostCommentsTableViewCell.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 03/04/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class ViewPostCommentsTableViewCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userComment: UITextView!
    
    //MARK: - override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
