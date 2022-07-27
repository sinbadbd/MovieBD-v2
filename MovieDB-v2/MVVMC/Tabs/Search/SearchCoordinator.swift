//
//  SearchCoordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit

final class SearchCoordinator: Coordinator {
    
    private var navController: UINavigationController?
    private var viewController: SearchVC
    private var childCo: Coordinator?
    private var viewModel: HomeVM
 
    init(navController: UINavigationController?) {
        self.navController = navController
        viewController = SearchVC()
        viewModel = HomeVM()
//        viewModel.delegate = viewController
        viewController.viewModel = viewModel
 
        //if InboxManager.isEmpty { InboxManager.mockList() }
    }
}
extension SearchCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
