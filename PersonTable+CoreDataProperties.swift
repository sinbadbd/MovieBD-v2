//
//  PersonTable+CoreDataProperties.swift
//  MovieDB-v2
//
//  Created by Imran on 15/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonTable> {
        return NSFetchRequest<PersonTable>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var gender: String?

}
