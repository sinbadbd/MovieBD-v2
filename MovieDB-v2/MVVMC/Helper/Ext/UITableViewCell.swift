//
//  UITableViewCell.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    static func getCell<T: UITableViewCell>(_: T.Type) -> T where T: Reusable {
        let bundle = Bundle(for: T.self)
        let cell = bundle.loadNibNamed(T.nibName, owner: self, options: nil)?.first as? T
        return cell ?? T()
    }
}
