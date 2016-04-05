//
//  CoreDaoQuestion.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 05/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDaoQuestion {
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - VALIDATION
    
    func validation(result: NSMutableArray) {
        if self.count() > 0 {
            self.delete()
        }
        self.insert(result)
    }
    
    // MARK: - INSERT
    
    func insert(result: NSMutableArray) {
        
        for info in result {
            
            let entityDescription = NSEntityDescription.entityForName("Question", inManagedObjectContext: delegate.managedObjectContext)
            let question = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: delegate.managedObjectContext)
            
            question.setValue(info.valueForKey("title"), forKey: "title")
            question.setValue(info.valueForKey("body"),  forKey: "body")
            question.setValue(info.valueForKey("score") as! Int, forKey: "vote")
            question.setValue(info.valueForKey("question_id") as! Int, forKey: "question_id")
            question.setValue(info.valueForKey("display_name"), forKey: "user")
            question.setValue(info.valueForKey("profile_image"), forKey: "photoUser")
            
            do {
                try question.managedObjectContext?.save()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - FETCH
    
    func fetch() -> NSArray {
        
        var result = NSArray()
        let fetchRequest = NSFetchRequest()
        
        let entityDescription = NSEntityDescription.entityForName("Question", inManagedObjectContext: delegate.managedObjectContext)
        
        fetchRequest.entity = entityDescription
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            result = try delegate.managedObjectContext.executeFetchRequest(fetchRequest)
            if result.count > 0 {
                return result
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return result
    }
    
    // MARK: - COUNT
    
    func count() -> Int {
        let fetchRequest = NSFetchRequest()
        
        let entityDescription = NSEntityDescription.entityForName("Question", inManagedObjectContext: delegate.managedObjectContext)
        
        fetchRequest.entity = entityDescription
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try delegate.managedObjectContext.executeFetchRequest(fetchRequest).count
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return 0
    }
    
    // MARK: - DELETE
    
    func delete() {
        
        let fetchRequest = NSFetchRequest()
        
        let entityDescription = NSEntityDescription.entityForName("Question", inManagedObjectContext: delegate.managedObjectContext)
        
        fetchRequest.entity = entityDescription
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let result = try delegate.managedObjectContext.executeFetchRequest(fetchRequest)
            if result.count > 0 {
                
                for question in result {
                    
                    delegate.managedObjectContext.deleteObject(question as! NSManagedObject)
                    
                    do {
                        
                        try delegate.managedObjectContext.save()
                        
                    } catch {
                        let fetchError = error as NSError
                        print(fetchError)
                    }
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
}
