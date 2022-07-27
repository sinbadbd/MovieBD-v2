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
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        Log.info()

        viewModel.onCompletion = { [weak self] movie in
            self?.setDetailsVC(movie: movie)
        }
    }
    
    func stop() {
        viewController.pop()
    }
    
   deinit{ Log.info() }
}

extension  HomeCoordinator {
    func setDetailsVC(movie: Result?){
        let coord = MoviesDetailsCoordinator(navController: navController, id: movie?.id ?? 0, movie: movie)
//        coord.getMovieDetails(for: movie?.id ?? 0)
//        coord.getMovieDetails(for: movie?.id ?? 0) {[weak self] in
//
//        }
//        coord.getMovieDetails(for: movie?.id) {[weak self] movieid in
//            
//        }
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
