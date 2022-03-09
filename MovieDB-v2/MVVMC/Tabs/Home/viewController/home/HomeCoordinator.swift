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
    private var viewModel: HomeVM
    
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
}

extension  HomeCoordinator {
    func setDetailsVC(){
        let coor = MoviesDetailsCoordinator(navController: navController)
        coor.start()
        
        
    }
}



extension HomeCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
