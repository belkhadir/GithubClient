//
//  ContributorViewController.swift
//  Github
//
//  Created by Anas Belkhadir on 15/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import UIKit

class ContributorViewController: UITableViewController{
    
    
    var contributors = [Contributor]()
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GithubClient.sharedInstance().contributorOfRepositerie({
            (success, result) in
            if success {
                self.contributors = result!
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }else{
                //showing error
            }
            
        })
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contributors.count > 0 {
            loading.stopAnimating()
            return contributors.count
        }else{
            loading.startAnimating()
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let contributor = contributors[indexPath.row]
        let identifier = "contributorCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)!
        
        GithubClient.sharedInstance().imageOfContributor(contributor.avatar,completionHandler: { data in
            dispatch_async(dispatch_get_main_queue(), {
                cell.imageView?.image = UIImage(data: data!)!
            })
        })
        cell.textLabel!.text = contributor.login
        
        
        
        
        return cell
        
    }
}
