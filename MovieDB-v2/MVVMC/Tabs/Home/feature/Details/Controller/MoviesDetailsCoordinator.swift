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
    private var viewModel: DetailsVM
    var onBack: Completion?
    
    init(movie: Result?,navController: UINavigationController?) {
        self.navController = navController
        viewController = MoviesDetailsVC()
        viewModel = DetailsVM(movie: movie)
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        Log.info()
        
        setActorLanding()
    }
    
    func setActorLanding(){
        viewModel.onCompletionMovieCast = {[weak self] casts in
            self?.loadActorLanding(cast: casts)
        }
    }
    
    func start() {
        Log.info()
        viewController.onBack = onBack
        navController?.push(vc: viewController)
    }
    
    func stop() { viewController.pop() }
}

extension MoviesDetailsCoordinator {
    func loadActorLanding(cast: MovieCast?){
        let coord = ActorsCoordinator(cast: cast, navController: navController)
        coord.start()
    }
}


extension MoviesDetailsCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
