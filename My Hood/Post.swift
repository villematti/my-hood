//
//  Post.swift
//  My Hood
//
//  Created by Ville-Matti Hakanpää on 07/01/16.
//  Copyright © 2016 Ville-Matti Hakanpää. All rights reserved.
//

import Foundation

// THe custom post model class what determines what kind of data our posts will have.
class Post: NSObject, NSCoding {

    // Set our properties as private
    private var _imagePath: String!
    private var _title: String!
    private var _postDescription: String!
    
    // Hide data with computed properties
    var imagePath: String {
        return _imagePath
    }
    
    var title: String {
        return _title
    }
    
    var postDesc: String {
        return _postDescription
    }
    
    // Initial function what requires imagePath title and description to be set
    init(imagePath: String, title: String, description: String) {
        self._imagePath = imagePath
        self._title = title
        self._postDescription = description
    }
    
    // These three are needed for encoding every time!!! We are using UserDefaults after all.
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._imagePath = (aDecoder.decodeObjectForKey("imagePath") as? String)
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDescription = aDecoder.decodeObjectForKey("description") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        aCoder.encodeObject(self._title, forKey: "title")
        aCoder.encodeObject(self._postDescription, forKey: "description")
    }
}