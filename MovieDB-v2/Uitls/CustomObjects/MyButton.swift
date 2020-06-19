//
//  MyButton.swift
//  CustomApp
//
//  Created by Imran on 5/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit
class MyButton: UIButton {
    
    // var buttonTitle:String!
    convenience init(frame:CGRect = .zero, setTitle:String = "", bgColor:UIColor? = .init(), textColor:UIColor? = .init()) {
        self.init(frame : frame)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 4
        self.setTitle(setTitle.uppercased(), for: .normal)
    }
}
