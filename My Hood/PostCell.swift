//
//  PostCell.swift
//  My Hood
//
//  Created by Ville-Matti Hakanpää on 07/01/16.
//  Copyright © 2016 Ville-Matti Hakanpää. All rights reserved.
//

import UIKit

// Custom cell class for our prototype cell
class PostCell: UITableViewCell {

    // Cell outlets
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Make cell image round
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
    }
    
    // Configure the cell data for display
    func configureCell (post: Post) {
        self.titleLbl.text = post.title
        self.descLbl.text = post.postDesc
        // Get image path from DataService
        postImg.image = DataService.instance.imageForPath(post.imagePath)
    }
}
