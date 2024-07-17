//
//  Contact+CoreDataProperties.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/17/24.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var image: Data?

}

extension Contact : Identifiable {

}
