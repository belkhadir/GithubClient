//
//  Code.swift
//  Github
//
//  Created by Anas Belkhadir on 14/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import Foundation

struct Code {
    var name:String
    var type: String
    
    init(parameter: [String:AnyObject]){
        name = parameter["name"] as! String
        type = parameter["type"] as! String
    }
    
}