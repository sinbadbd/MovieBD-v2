//
//  UIViewController + Ext.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

public extension UIViewController {
    static func getVC<T: UIViewController>(_: T.Type, from storyboardName: String, bundle: Bundle? = nil) -> T where T: Reusable {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle ?? Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: T.nibName) as? T
        return vc ?? T()
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
     
}


public extension UIViewController {
    func setStatusBarBackground(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
                  let frame = window.windowScene?.statusBarManager?.statusBarFrame else { return }
            let statusBar = UIView(frame:  frame)
            statusBar.backgroundColor = color
            window.addSubview(statusBar)
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
}
