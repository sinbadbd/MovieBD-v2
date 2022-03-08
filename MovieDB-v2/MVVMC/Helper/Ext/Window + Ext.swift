//
//  Window + Ext.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    func set(_ viewController: UIViewController?) {
        rootViewController = viewController
        makeKeyAndVisible()
        animate()
    }
    
    func animate() {
        UIView.transition(with: self, duration: 0.3,
                          options: .transitionCrossDissolve, animations: {}, completion: nil)
    }
}


public protocol Reusable: AnyObject {
    static var nibName: String { get }
}

public extension Reusable {
    static var nibName: String { return String(describing: self) }
}

