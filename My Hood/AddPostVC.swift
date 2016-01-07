//
//  AddPostVC.swift
//  My Hood
//
//  Created by Ville-Matti Hakanpää on 07/01/16.
//  Copyright © 2016 Ville-Matti Hakanpää. All rights reserved.
//

import UIKit

// Heritance needed by this class
class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Outlets for the addPost view
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    // A placeholder for the image picker
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lets make preview image round and cut off everything what stays outside.
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
        
        // Initialize imgae picker
        imagePicker = UIImagePickerController()
        
        // Set delegate for image picker
        imagePicker.delegate = self
        
        // Create tapping recognizer with dismissKeyboard action
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        // Add dismissKeyboard tap recognizer to view
        view.addGestureRecognizer(tap)
    }
    
    // Dismiss keyboard when clicking outside the keyboard.
    func dismissKeyboard() {
        // Dismiss the keyboard
        view.endEditing(true)
    }

    // Primary function for creating a new post
    @IBAction func makePostBtnPressed(sender: AnyObject) {
        
        // If we have a title, description and and image has been chosen.
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {
            
            // Set the image path as describet in DataService instance
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            
            // Create the post it self
            let post = Post(imagePath: imgPath, title: title, description: desc)
            
            // Save post through DataService
            DataService.instance.addPost(post)
        }
        
        // Alert notification called postsLoaded
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
        
        // Got back to the front page.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // When cancel button is pressed
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        
        // Go back to the front page.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // When user wants to choose and image from their image library
    @IBAction func addPicButtonPressed(sender: UIButton!) {
        
        // Does stuff what allowes the functionality in question.
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Gets called when an image is picked successfully
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        // Hide the library
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        // Display chosen image in the preview view
        postImg.image = image
    }
}
