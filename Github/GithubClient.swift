//
//  GithubClient.swift
//  Github
//
//  Created by Anas Belkhadir on 10/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import Foundation

class GithubClient: NSObject {
    
    var session: NSURLSession
    
    var sessionID: String? = nil
    var userID: String? = nil
    var objectID: String? = nil
    

    //Mark: Initializers
    private override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    func taskForGetMethod(url: String,parameter: [String: AnyObject]?,completionHandeler: (result:AnyObject!, error: ErrorType?) -> Void ) ->NSURLSessionDataTask {

        var urlString = ""
        if let parameter = parameter {
            urlString = url + GithubClient.escapedParameters(parameter)
        }else{
            urlString = url
        }
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)

        
        print(urlString)
        let task = session.dataTaskWithRequest(request) { (data , response , error) in
            guard (error == nil) else{
                print("There was error with the request")
                return
            }
            
            GithubClient.statusCodeWithCompletionHandler(response!){
                success in
                if !success {
                    return
                }
            }
            
            
            guard let data = data else{
                print("no data was returned by the server")
                return
            }
            GithubClient.parseJSONWithCompletionHandler(data,completionHandler: completionHandeler)
        }
        task.resume()
        return task
    }
    
    func getSingleImage(url: String,
        completionHandler: (data: NSData?, success: Bool)->Void ) -> NSURLSessionDataTask {
            
            let URL = NSURL(string: url)
            let request = NSURLRequest(URL: URL!)
            
            let task = session.dataTaskWithRequest(request){ (data, response, error) in
                guard error == nil else{
                    completionHandler(data: nil, success: false)
                    return
                }
                
                GithubClient.statusCodeWithCompletionHandler(response!){
                    success in
                    if !success{
                        completionHandler(data: nil, success: false)
                    }
                }
                guard let data = data else {
                    completionHandler(data: nil, success: false)
                    return
                }
                completionHandler(data: data, success: true)
                
            }
            task.resume()
            return task
    }
    
    
    class func statusCodeWithCompletionHandler(response: AnyObject, completionHandler: (success: Bool) -> Void){
        guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
            if let response = response as? NSHTTPURLResponse {
                print("Your request returned an invalid response! Status code: \(response.statusCode)!")
            } else {
                print("Your request returned an invalid response!")
            }
            completionHandler(success: false)
            return
        }
        completionHandler(success: true)
        
    }
    
    class func parseJSONWithCompletionHandler(data: NSData,completionHandler: (result: AnyObject!,error: NSError?) -> Void ){
        
        var parsedResult: AnyObject!
        do{
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                completionHandler(result: parsedResult, error: nil)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
       
    }
    
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
    
    class func sharedInstance() -> GithubClient {
        struct Singleton {
            static var sharedInstance = GithubClient()
        }
        return Singleton.sharedInstance
    }
    
}