//
//  EmployeTable+CoreDataProperties.swift
//  MovieDB-v2
//
//  Created by Imran on 5/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeTable> {
        return NSFetchRequest<EmployeTable>(entityName: "Employe")
    }

    @NSManaged public var title: String?
    @NSManaged public var hiredate: Date?
    @NSManaged public var indentifire: String?
    @NSManaged public var isManager: Bool
    @NSManaged public var department: DepartmentTable?

}
