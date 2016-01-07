//
//  DataService.swift
//  My Hood
//
//  Created by Ville-Matti Hakanpää on 07/01/16.
//  Copyright © 2016 Ville-Matti Hakanpää. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    // Create the singleton instance
    static let instance = DataService()
    
    // Set the default key for UserDefaults key
    let KEY_POSTS = "posts"
    
    // Initialize a variable what holds all excisting posts in an array
    private var _loadedPosts = [Post]()
    
    // Property what returns all excisting posts
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    // Primary function for saving data
    func savePosts() {
        
        // Turn all posts into bits
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        
        // Save encoded data to UserDefaults with KEY_POSTS key
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        
        // Synctonize UserDefaults so information gets saved
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Load all posts
    func loadPosts() {
        
        // Check if we can find encoded data from UserDefaults with given key
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            
            // If data is found, try to decode it to Posts array
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                
                // Save found array to private property
                _loadedPosts = postsArray
            }
        }
    }
    
    // Save image and create a path for it
    func saveImageAndCreatePath(image: UIImage) -> String {
        
        // Create a PNG image
        let imgData = UIImagePNGRepresentation(image)
        
        // Use NSDate to create a unique name for the image file
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        
        // Get full path to the image
        let fullPath = documentsPathForFilename(imgPath)
        
        // If PNG data excists, sava image to given path
        imgData?.writeToFile(fullPath, atomically: true)
        
        // Return the full filename of the image.
        return imgPath
    
    }
    
    // Tries to find an image from given string
    func imageForPath(path: String) -> UIImage? {
        
        // Find a document path for given path
        let fullPath = documentsPathForFilename(path)
        
        // Create and UIImage from given fullPath
        let image = UIImage(named: fullPath)
        
        // Return the image if everything went correct
        return image
    }
    
    // Function for adding a post
    func addPost(post: Post) {
        
        // Add new post at the and of all excisting posts
        _loadedPosts.append(post)
        
        // Save post to UserDefaults
        savePosts()
        
        // Load posts again with just saved posts included
        loadPosts()
    }
    
    // Finds the docment path for given path.
    func documentsPathForFilename(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullPath = paths[0] as NSString
        
        return fullPath.stringByAppendingPathComponent(name)
    }
    
}