//
//  FitTableView.swift
//  MovieDB-v2
//
//  Created by Imran on 21/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import Foundation
import UIKit

class FitTableView: UITableView {

        override var intrinsicContentSize: CGSize {
            self.layoutIfNeeded()
            return self.contentSize
        }

        override var contentSize: CGSize {
            didSet{
                self.invalidateIntrinsicContentSize()
            }
        }

        override func reloadData() {
            super.reloadData()
            self.invalidateIntrinsicContentSize()
        }
    

}

