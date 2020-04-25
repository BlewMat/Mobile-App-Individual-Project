//
//  Item+CoreDataProperties.swift
//  Homepwner
//
//  Created by Matthew Blewett on 4/25/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var date: String?
    @NSManaged public var location: String?
    @NSManaged public var loser: String?
    @NSManaged public var mvp: String?
    @NSManaged public var sb: String?
    @NSManaged public var score: String?
    @NSManaged public var winner: String?

}
