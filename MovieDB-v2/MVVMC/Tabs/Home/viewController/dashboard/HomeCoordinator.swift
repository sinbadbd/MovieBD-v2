//
//  HomeCoordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private var navController: UINavigationController?
    private var viewController: HomeVC
    private var childCo: Coordinator?
    private var oldStack: [UIViewController]?
    private var viewModel: HomeVM
    var onBack: Completion?
    
    init(navController: UINavigationController?) {
        self.navController = navController
        viewController = HomeVC()
        viewModel = HomeVM()
        //        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        Log.info()
        //if InboxManager.isEmpty { InboxManager.mockList() }
        
        viewModel.onCompletion = { [weak self] in
            self?.setDetailsVC()
        }
    }
    
    func stop() {
        guard let stack = oldStack else { return }
        childCo = nil
        navController?.setViewControllers(stack, animated: true)
    }
    
   deinit{ Log.info() }
}

extension  HomeCoordinator {
    func setDetailsVC(){
        let coord = MoviesDetailsCoordinator(navController: navController)
        childCo = coord
        coord.onBack = { [weak self] in self?.removeChaild() }
        coord.start()
    }
    
    func removeChaild(){
        childCo?.stop?()
        childCo = nil
    }
}

extension HomeCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
