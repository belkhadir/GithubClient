//
//  IssueViewController.swift
//  Github
//
//  Created by Anas Belkhadir on 15/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import UIKit

class IssueViewController: UITableViewController{
    
    
    var issues = [String]()
    
    @IBOutlet weak var loading: UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        GithubClient.sharedInstance().issueOfRepositerie({
            (success, result) in
            
            if success {
                self.issues = result!
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }else{
                //show an alert
            }
        })
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if issues.count > 0 {
            loading.stopAnimating()
            return issues.count
        }else{
            loading.startAnimating()
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let issue = issues[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("issueCell")!
        cell.imageView?.image = UIImage(named: "issue")
        cell.textLabel?.text = issue
        
        return cell
        
    }
    
    
    
    
    
    
    
    
}