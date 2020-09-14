//
//  PersonTable+CoreDataProperties.swift
//  MovieDB-v2
//
//  Created by Imran on 5/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonTable> {
        return NSFetchRequest<PersonTable>(entityName: "Person")
    }

    @NSManaged public var date_of_birth: Date?
    @NSManaged public var name: String?

}
