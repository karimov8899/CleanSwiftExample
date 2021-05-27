//
//  Places+CoreDataProperties.swift
//  
//
//  Created by Dave on 5/20/21.
//
//

import Foundation
import CoreData


extension Places {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Places> {
        return NSFetchRequest<Places>(entityName: "Places")
    }

    @NSManaged public var url: String?
    @NSManaged public var detail: String?
    @NSManaged public var titile: String?

}
