//
//  MoviesDetailsCoordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

final class MoviesDetailsCoordinator: Coordinator {
    
    private var navController: UINavigationController?
    private var viewController: MoviesDetailsVC
    private var childCo: Coordinator?
//    private var viewModel: HomeVM
    
    init(navController: UINavigationController?) {
        self.navController = navController
        viewController = MoviesDetailsVC()
//        viewModel = HomeVM()
        //        viewModel.delegate = viewController
//        viewController.viewModel = viewModel
//        viewModel.delegate = viewController
        Log.info()
        //if InboxManager.isEmpty { InboxManager.mockList() }
    }
    
    func start() {
        Log.info()
        navController?.push(vc: viewController)
    }
}
extension MoviesDetailsCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
