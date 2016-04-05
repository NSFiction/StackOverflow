//
//  CoreDaoAnswer.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 05/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDaoAnswer {
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - VALIDATION
    
    func validation(result: NSMutableArray, question: Question) {
        if self.count() > 0 {
            self.delete()
        }
        self.insert(result, question: question)
    }
    
    // MARK: - INSERT
    
    func insert(result: NSMutableArray, question: Question) {
        
        for info in result {
            
            let entityDescription = NSEntityDescription.entityForName("Answer", inManagedObjectContext: delegate.managedObjectContext)
            let answer = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: delegate.managedObjectContext)
            
            answer.setValue(info.valueForKey("display_name"), forKey: "user")
            answer.setValue(info.valueForKey("profile_image"),  forKey: "photoUser")
            answer.setValue(question, forKey: "questionofanswert")
            
            do {
                try answer.managedObjectContext?.save()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - FETCH
    
    func fetch() -> NSArray {
        
        var result = NSArray()
        let fetchRequest = NSFetchRequest()
        
        let entityDescription = NSEntityDescription.entityForName("Answer", inManagedObjectContext: delegate.managedObjectContext)
        
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
        
        let entityDescription = NSEntityDescription.entityForName("Answer", inManagedObjectContext: delegate.managedObjectContext)
        
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
        
        let entityDescription = NSEntityDescription.entityForName("Answer", inManagedObjectContext: delegate.managedObjectContext)
        
        fetchRequest.entity = entityDescription
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let result = try delegate.managedObjectContext.executeFetchRequest(fetchRequest)
            if result.count > 0 {
                
                for answer in result {
                    
                    delegate.managedObjectContext.deleteObject(answer as! NSManagedObject)
                    
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
