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
    
    func getTaggedWithClosure(category: String, completion: (result: NSMutableArray) -> Void) {
        
        let tagged = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=\(category)&site=stackoverflow"
        
        Alamofire.request(.GET, tagged).responseJSON { response in
            print("Success: \(response.result.isSuccess)")
            
            let json = response.result.value as! NSDictionary
            let items = json.valueForKey("items") as! NSArray
            
            let questions = NSMutableArray()

            for item in items {
                let enumerates = item as! NSDictionary
                let objects = NSMutableDictionary()
                
                for (key, value) in enumerates {
    
                    if key as! String == "title" {
                        objects.setValue(value, forKeyPath: "title")
                    }
                    
                    if key as! String == "score" {
                        objects.setValue(value, forKeyPath: "score")
                    }
                    
                    if key as! String == "owner" {
                        let owner = value as! NSDictionary

                        objects.setValue(owner.valueForKey("display_name"), forKeyPath: "display_name")
                        objects.setValue(owner.valueForKey("profile_image"), forKeyPath: "profile_image")
                    }

                }
                
                questions.addObject(objects)
                
            }
            
            completion(result: questions)
        }
        
    }

}