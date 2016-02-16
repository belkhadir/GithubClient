//
//  SearchViewController.swift
//  Github
//
//  Created by Anas Belkhadir on 13/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//


import UIKit

class DisplayResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var result:[Repositorie] = []
    var languageName: String?
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if !isConnectedToNetwork() {
            showAlert(.connectivity)
        }else{
            GithubClient.sharedInstance().popularRepositoriesByLanguage(languageName!, completionHandler: {
                (succes, result) in
                if succes {
                    self.result = result!
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }else{
                   self.showAlert(.server)
                }
            
            })
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if result.count > 0 {
            loading.stopAnimating()
            return result.count
        }else{
            loading.startAnimating()
            return 0
        }
        
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        SharedRepositerie.sharedInstance().repositerie = result[indexPath.row]
        let tabBarController = storyboard?.instantiateViewControllerWithIdentifier("detailedInformation") as! UITabBarController
        dispatch_async(dispatch_get_main_queue(), {
            self.navigationController?.pushViewController(tabBarController, animated: true)
        })
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "displaySearch"
        let information = result[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! DisplaySearchCellView
        cell.name.numberOfLines = 0
        cell.name.text = information.name
        cell.forks.text = String(information.forks)
        cell.stars.text = String(information.stargazersCount)
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
}