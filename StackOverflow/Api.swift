//
//  Api.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 01/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import Alamofire

class Api {

    func getConnection() -> Bool {
        let manager = NetworkReachabilityManager()
        let status = (manager?.isReachable)!
        return status
    }

    func getTaggedWithClosure(category: String, completion: (result: NSMutableArray) -> Void) {
        
        let tagged = "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=\(category)&site=stackoverflow"
        
        Alamofire.request(.GET, tagged).responseJSON { response in

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
                        objects.setValue(value as! Int, forKeyPath: "score")
                    }
                
                    if key as! String == "question_id" {
                        objects.setValue(value as! Int, forKeyPath: "question_id")
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
    
    func getAnswersWithClosure(question_id: Int, completion: (result: NSMutableArray) -> Void) {
        
        let tagged = "https://api.stackexchange.com/2.2/questions/\(question_id)/answers?order=desc&sort=activity&site=stackoverflow"
        
        Alamofire.request(.GET, tagged).responseJSON { response in
            
            let json = response.result.value as! NSDictionary
            let items = json.valueForKey("items") as! NSArray
            
            let questions = NSMutableArray()
            for item in items {
                let enumerates = item as! NSDictionary
                let objects = NSMutableDictionary()
                
                for (key, value) in enumerates {
                    
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