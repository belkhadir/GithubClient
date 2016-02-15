//
//  CodeViewController.swift
//  Github
//
//  Created by Anas Belkhadir on 14/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var watch: UILabel!
    @IBOutlet weak var star: UILabel!
    
    @IBOutlet weak var fork: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var result = [Code]()
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = (SharedRepositerie.sharedInstance().repositerie?.name)!
        star.text = String((SharedRepositerie.sharedInstance().repositerie?.stargazersCount)!)
        fork.text = String((SharedRepositerie.sharedInstance().repositerie?.forks)!)
        
        
        GithubClient.sharedInstance().contentOfRepositorie({
            (success, result) in
            if success {
                self.result = result!
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }else{
                //Showing error
            }
        })
 
        
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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let singleFile = result[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("contentFile")!
        cell = configureCell(cell, file: singleFile)
        
        return cell
    }
    
    
    
    func configureCell(cell: UITableViewCell, file: Code)-> UITableViewCell {
        
        if file.type == "file" {
            cell.imageView?.image = UIImage(named: "file")
        }else{
            cell.imageView?.image = UIImage(named: "directory")
        }
        cell.textLabel?.text = file.name
        return cell
        
    }
    
    
    
    
    
    
}