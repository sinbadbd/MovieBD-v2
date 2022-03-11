//
//  ActorsCoordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 11/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

final class ActorsCoordinator: Coordinator {
    
    private var navController: UINavigationController?
    private var viewController: ActorsVC
    private var childCo: Coordinator?
    private var viewModel: ActorsVM
    var onBack: Completion?
    
    init(cast: MovieCast?,navController: UINavigationController?) {
        self.navController = navController
        viewController = ActorsVC()
        viewModel = ActorsVM(cast: cast)
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        Log.info()
    }
    
    func start() {
        Log.info()
        viewController.onBack = onBack
        navController?.push(vc: viewController)
    }
    
    func stop() { viewController.pop() }
}
extension ActorsCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
