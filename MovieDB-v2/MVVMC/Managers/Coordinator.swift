//
//  Coordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

@objc public protocol Coordinator: AnyObject {
    @objc optional func start()
    @objc optional func stop()
    @objc optional func getVC() -> UIViewController
}

public protocol TabBarItemCoordinator: Coordinator { func getVC() -> UIViewController }

extension Coordinator {
    public var navController: UINavigationController? { UIWindow.key?.rootViewController as? UINavigationController }
}
