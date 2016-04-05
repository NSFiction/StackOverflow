//
//  Answer+CoreDataProperties.swift
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

extension Answer {

    @NSManaged var user: String?
    @NSManaged var photoUser: String?
    @NSManaged var questionofanswert: Question?

}
