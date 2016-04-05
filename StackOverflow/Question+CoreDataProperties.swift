//
//  Question+CoreDataProperties.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 05/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Question {

    @NSManaged var body: String?
    @NSManaged var title: String?
    @NSManaged var user: String?
    @NSManaged var vote: NSNumber?
    @NSManaged var photoUser: String?
    @NSManaged var question_id: NSNumber?
    @NSManaged var answerofquestion: Answer?

}
