//
//  MovieDataSaveTable+CoreDataProperties.swift
//  MovieDB-v2
//
//  Created by Imran on 5/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieDataSaveTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDataSaveTable> {
        return NSFetchRequest<MovieDataSaveTable>(entityName: "MovieDataSave")
    }

    @NSManaged public var isFavorite: Bool

}
