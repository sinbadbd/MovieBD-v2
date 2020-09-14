//
//  DepartmentTable+CoreDataProperties.swift
//  MovieDB-v2
//
//  Created by Imran on 5/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//
//

import Foundation
import CoreData


extension DepartmentTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DepartmentTable> {
        return NSFetchRequest<DepartmentTable>(entityName: "Department")
    }

    @NSManaged public var address: String?
    @NSManaged public var zipcode: Int32
    @NSManaged public var phone: String?
    @NSManaged public var city: String?
    @NSManaged public var name: String?
    @NSManaged public var employe: EmployeTable?

}
