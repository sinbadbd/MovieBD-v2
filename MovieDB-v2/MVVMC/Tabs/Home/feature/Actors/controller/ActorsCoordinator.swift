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
    public var movies: Result?
    
    init(cast: MovieCast?, movie: Result?, navController: UINavigationController?) {
        self.navController = navController
        viewController = ActorsVC()
        viewModel = ActorsVM(cast: cast)
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        self.movies = movie
        Log.info()
    }
    
    func start() {
        Log.info()
        viewController.onBack = onBack
        navController?.push(vc: viewController)
        
        viewModel.onCastCompletion = { [weak self] casts in
            self?.setDetailsVC( movie: self?.movies, id: casts.id ?? 0)
        }
    }

    func stop() { viewController.pop() }
}


extension  ActorsCoordinator {
    func setDetailsVC(movie: Result? , id: Int){
        let coord = MoviesDetailsCoordinator(navController: navController, id: id, movie: movie)
        childCo = coord
        coord.onBack = { [weak self] in self?.removeChaild() }
        coord.start()
    }

    func removeChaild(){
        childCo?.stop?()
        childCo = nil
    }
}

extension ActorsCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
