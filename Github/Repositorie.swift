//
//  Repositories.swift
//  Github
//
//  Created by Anas Belkhadir on 12/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import Foundation

struct Repositorie {
    
    let contentsUrl: String

    let description: String
    let contributorsUrl: String
    let forks:  Int
    let hasIssues: Int
    let name: String
    let stargazersCount: Int
    var issuesUrl: String? = nil
    
    init(information: [String: AnyObject]) {
        contentsUrl = information[GithubClient.JsonKey.contentsUrl] as! String
        contributorsUrl = information[GithubClient.JsonKey.contributorsUrl] as! String
        description = information[GithubClient.JsonKey.description] as! String
        forks = information[GithubClient.JsonKey.forks] as! Int
        hasIssues = information[GithubClient.JsonKey.hasIssues] as! Int
        name = information[GithubClient.JsonKey.name] as! String
        stargazersCount = information[GithubClient.JsonKey.stargazersCount] as! Int
        if hasIssues == 1 {
            issuesUrl = information[GithubClient.JsonKey.issuesUrl] as? String
        }
        
    }
    
}

class SharedRepositerie {
    
    
    var repositerie: Repositorie?
    
    class func sharedInstance() -> SharedRepositerie{
        struct Singleton {
            static var sharedInstance = SharedRepositerie()
        }
        return Singleton.sharedInstance
    }
}


