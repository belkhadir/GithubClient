//
//  ExtensionViewController.swift
//  Github
//
//  Created by Anas Belkhadir on 16/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import UIKit
import SystemConfiguration

extension UIViewController {
    
    
    enum TypeAlert {
        case connectivity
        case server
    }
    
    
    func showAlert(typeAlert: TypeAlert){
        var title = ""
        var message = ""
        let buttonTitle = "OK"
        switch typeAlert {
            case .connectivity:
                    title = "Error connection"
                    message = "Unable to connect, connection problem"
            case .server :
                    title = "Error occu"
                    message = "Try later"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: {action in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
}
