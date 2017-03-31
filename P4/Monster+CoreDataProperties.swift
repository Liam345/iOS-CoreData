//
//  Monster+CoreDataProperties.swift
//  P4
//
//  Created by champ on 30/03/17.
//  Copyright © 2017 champ. All rights reserved.
//

import Foundation
import CoreData


extension Monster {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Monster> {
        return NSFetchRequest<Monster>(entityName: "Monster");
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int32
    @NSManaged public var health: Int32
    @NSManaged public var power: Int32
    @NSManaged public var species: String?

}
