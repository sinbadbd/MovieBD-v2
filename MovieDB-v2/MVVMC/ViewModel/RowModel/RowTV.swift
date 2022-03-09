//
//  RowTV.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
 
public protocol Model: Codable { }

public protocol ItemType { }

public protocol Row { }

public struct TVRow: Row {
    public var type: ItemType
    public var model: Model?
    public var selected: Bool
    public var cell: UITableViewCell
    
    public init(type: ItemType, cell: UITableViewCell) {
        self.type = type
        self.cell = cell
        self.model = nil
        self.selected = false
    }
    
    public init(type: ItemType, model: Model, cell: UITableViewCell) {
        self.type = type
        self.cell = cell
        self.model = model
        self.selected = false
    }
    
    public init(type: ItemType, model: Model, selected: Bool, cell: UITableViewCell) {
        self.type = type
        self.cell = cell
        self.model = model
        self.selected = selected
    }
    
    public static func == (lhs: TVRow, rhs: TVRow) -> Bool {
        return lhs.cell == rhs.cell
    }
}
