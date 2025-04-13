//
//  User+CoreDataProperties.swift
//  NetPriorityAI
//
//  Created by Howard Tung on 4/12/25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var occupation: String?
    @NSManaged public var company: String?
    @NSManaged public var about: String?

}

extension User : Identifiable {

}
