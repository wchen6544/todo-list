//
//  QLLink+CoreDataProperties.swift
//  wilsonsmenuapp
//
//  Created by Wilson Chen on 11/3/22.
//
//

import Foundation
import CoreData


extension QLLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QLLink> {
        return NSFetchRequest<QLLink>(entityName: "QLLink")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var data: String?
    @NSManaged public var done: Bool
    
    
    var wrappedID: UUID { id! }
    var wrappedData: String { data! }
    var wrappedDone: Bool { done }

}

extension QLLink : Identifiable {

}
