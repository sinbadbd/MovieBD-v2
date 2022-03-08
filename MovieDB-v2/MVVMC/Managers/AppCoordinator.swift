//
//  AppCoordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    private (set) var window: UIWindow?
    private (set) var coordinator: Coordinator?

    init(window: UIWindow?) {
        self.window = window
        window?.backgroundColor  = .white
    }
    
    func setup(window: UIWindow?) { self.window = window }
 
    func start() { Log.info();setupPlatform() }
 
}
extension AppCoordinator {
    func setupPlatform() {
        let coord = PlatformCoordinator(window: window)
//        delegate = coord
        coordinator = coord
//        coord.onRequest = { [weak self] action in self?.hande(action) }
        coord.start()
    }
}
