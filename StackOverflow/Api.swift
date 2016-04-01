//
//  Api.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 01/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import Alamofire

struct URL {
    var category = "https://api.stackexchange.com/2.2/tags?order=desc&sort=popular&site=stackoverflow"
}

class Api {

    func getConnection() -> Bool {
        let manager = NetworkReachabilityManager()
        let status = (manager?.isReachable)!
        return status
    }
    
    func getCategoryWithClosure(completion: (NSArray?) -> ()) -> () {
        
        Alamofire.request(.GET, URL().category).responseJSON { response in
            
            let status = response.result.isSuccess
            
            print("Sucess: \(status)")
            
            if status {
                let json = response.result.value as! NSDictionary
                let tags = json.valueForKey("items") as! NSArray
                
                let list = NSMutableArray()
                
                for info in tags {
                    
                    let name = info.valueForKey("name") as! String
                    
                    if name.containsString("iphone")
                        || name.containsString("cocoa touch")
                        || name.containsString("uikit")
                        || name.containsString("objective-c")
                        || name.containsString("swift"){
                        
                        list.addObject(name)
                        
                    }
                }
                completion(list)
            }
            completion(nil)
            
        }
    }
    
    func getTaggedWithClosure(category: String, completion: (result: NSArray) -> Void) {
        
        let tagged = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=\(category)&site=stackoverflow"
        
        Alamofire.request(.GET, tagged).responseJSON { response in
            print("Success: \(response.result.isSuccess)")
            
            let json = response.result.value as! NSDictionary
            let items = json.valueForKey("items") as! NSArray
            
            print("items: \(items)")
        }
        
    }

}