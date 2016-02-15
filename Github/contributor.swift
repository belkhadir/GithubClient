//
//  contributor.swift
//  Github
//
//  Created by Anas Belkhadir on 15/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import Foundation

struct Contributor {
    
    let login:String
    let avatar:String
    
    init(parameter: [String:AnyObject]){
        self.avatar = parameter[GithubClient.JsonKey.avatar] as! String
        self.login = parameter[GithubClient.JsonKey.login] as! String
    }
    
}