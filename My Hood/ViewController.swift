//
//  ViewController.swift
//  My Hood
//
//  Created by Ville-Matti Hakanpää on 07/01/16.
//  Copyright © 2016 Ville-Matti Hakanpää. All rights reserved.
//

import UIKit

// ViewController for the front page. Acts as a datasoure and delegate for our tableView
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlet for tableView what will display posts
    @IBOutlet weak var tableView: UITableView!
    
    // Initialize posts array
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initilaize tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Load new posts through DataService
        DataService.instance.loadPosts()
        
        // Get notified when new posts are added
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
    }
    
    // Our tableView will have one section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // How many posts are loaded through DataService, will be the number we will have posts.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    // Fill out the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Get the post in question from DataService
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        // Put current post in reusable cell and return the cell
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }

    }
    
    // Set the height for our cell in tableView
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 83.0
    }

    // The selector function for observer what listens if new posts are added.
    func onPostsLoaded(notif: AnyObject) {
        tableView.reloadData()
    }
}

