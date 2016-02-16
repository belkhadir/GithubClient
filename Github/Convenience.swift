//
//  Convenience.swift
//  Github
//
//  Created by Anas Belkhadir on 12/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import Foundation

extension GithubClient {
    
    
    
    func popularRepositoriesByLanguage(language: String,completionHandler: (success: Bool,result: [Repositorie]? )-> Void){
        
        let parameters = [
            Parameter.q : "language:" + language ,
            Parameter.sort : Sort.stars.rawValue
        ]
        taskForGetMethod(Constant.REPOSITORIES_URL, parameter: parameters, completionHandeler: {
            (result, error) in
            if error == nil {
                if let result = result[JsonKey.items] as? [[String:AnyObject]]{
                    var fetchedResult = [Repositorie]()
                    for element in result {

                        fetchedResult.append(Repositorie(information: element))
                    }
                    completionHandler(success: true, result: fetchedResult)
                }
            }else{
                completionHandler(success: false, result: nil)
            }
        })
    }
    
    
    func contentOfRepositorie(completionHandler: (succes:Bool, result: [Code]? )->Void ){
        
        var urlString = SharedRepositerie.sharedInstance().repositerie?.contentsUrl
        urlString = urlString!.stringByReplacingOccurrencesOfString("{+path}", withString: "",
                            options: NSStringCompareOptions.LiteralSearch, range: nil)
   
        
        taskForGetMethod(urlString!, parameter: nil, completionHandeler: {
            (result, error) in
            if error == nil{
                if let result = result as? [[String:AnyObject]] {
                    var fetchedResult = [Code]()
                    for element in result {
                        fetchedResult.append(Code(parameter: element))
                    }
                    completionHandler(succes: true, result: fetchedResult)
                }
            }else{
                completionHandler(succes: false, result: nil)
            }
        })
    }
    
    
    func issueOfRepositerie(completionHandler: (succes: Bool, result: [String]?)->Void){
        var urlString = SharedRepositerie.sharedInstance().repositerie?.issuesUrl
        urlString = urlString!.stringByReplacingOccurrencesOfString("{/number}", withString: "",
            options: NSStringCompareOptions.LiteralSearch, range: nil)
        let parameter = [
            GithubClient.Parameter.sort: "updated"
        ]
        
        taskForGetMethod(urlString!, parameter: parameter, completionHandeler: {
            (result, error) in
            if error == nil {
                if let result = result as? [[String:AnyObject]] {
                    var fetchedResult = [String]()
                    for element in result {
                        fetchedResult.append(element[GithubClient.JsonKey.titleIssue] as! String)
                    }
                    completionHandler(succes: true, result: fetchedResult)
                }else{
                    completionHandler(succes: false, result: nil)
                }
            }else{
                completionHandler(succes: false, result: nil)
            }
        })
        
    }
    
    func contributorOfRepositerie(completionHandler: (succes: Bool, result: [Contributor]?)->Void){
        
        var urlString = SharedRepositerie.sharedInstance().repositerie?.contributorsUrl
        urlString = urlString!.stringByReplacingOccurrencesOfString("{/number}", withString: "",
            options: NSStringCompareOptions.LiteralSearch, range: nil)
        
    
        taskForGetMethod(urlString!, parameter: nil, completionHandeler: {
            (result, error) in
            if error == nil {
                
                if let result = result as? [[String:AnyObject]] {
                    var fetchedResult = [Contributor]()
                    for element in result {
                        fetchedResult.append(Contributor(parameter: element))
                    }
                    completionHandler(succes: true, result: fetchedResult)
                }else{
                    completionHandler(succes: false, result: nil)
                }
            }else{
                completionHandler(succes: false, result: nil)
            }

            
            
        })
    
    }
    
    func imageOfContributor(url: String,completionHandler: (result: NSData?) -> Void) {
        
        getSingleImage(url, completionHandler: {
            (data, success) in
            if success {
                completionHandler(result: data)
            }else{
                completionHandler(result: nil)
            }
            
        })
        
        
    }
    
    
    
    
    
    
    
    
    
    


}