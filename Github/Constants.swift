//
//  Constants.swift
//  Github
//
//  Created by Anas Belkhadir on 10/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import Foundation

extension GithubClient {
    
    struct Constant {
        
        static let BASIC_URL = "https://api.github.com/"
        static let REPOSITORIES_URL = "https://api.github.com/search/repositories"
        
    }
    
    enum Sort: String {
        
        case stars = "stars"
        case forks = "forks"
        case updated = "updated"
        
    }
    
    enum order: String {
        
        case asc = "asc"
        case desc = "desc"
        
    }
    
    struct Parameter {
        
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
        static let q = "q"
        static let sort = "sort"
        static let order = "order"
        
    }
    
    struct JsonKey {
        
        static let contentsUrl = "contents_url"
        static let items = "items"
        static let description = "description"
        static let contributorsUrl = "contributors_url"
        static let forks = "forks"
        static let hasIssues = "has_issues"
        static let name = "name"
        static let stargazersCount = "stargazers_count"
        static let issuesUrl = "issues_url"
        static let titleIssue = "title"
        static let avatar = "avatar_url"
        static let login = "login"
    }
        
    

}