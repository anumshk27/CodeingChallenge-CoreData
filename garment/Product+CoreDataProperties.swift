//
//  Product+CoreDataProperties.swift
//  garment
//
//  Created by Muhammad Anum on 09/11/2021.
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var created: Date?

}

extension Product : Identifiable {

}
