//
//  ViewController.swift
//  Github
//
//  Created by Anas Belkhadir on 09/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let languages = ["python","java","c","swift","cpp"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let searchVC = storyboard?.instantiateViewControllerWithIdentifier("result") as? DisplayResultViewController
        searchVC?.languageName = languages[indexPath.row]
        navigationController?.pushViewController(searchVC!, animated: true)
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let identifier: String = "languageName"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        cell!.textLabel!.text = languages[indexPath.row]

        
        return cell!
        
        
    }
    
    
    

}


