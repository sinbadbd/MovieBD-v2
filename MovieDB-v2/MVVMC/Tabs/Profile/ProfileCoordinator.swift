//
//  MoreCoordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private var navController: UINavigationController?
    private var viewController: UserProfileVC
    private var childCo: Coordinator?
    private var viewModel: HomeVM
 
    init(navController: UINavigationController?) {
        self.navController = navController
        viewController = UserProfileVC()
        viewModel = HomeVM()
//        viewModel.delegate = viewController
        viewController.viewModel = viewModel
 
        //if InboxManager.isEmpty { InboxManager.mockList() }
    }
}
extension ProfileCoordinator: TabBarItemCoordinator {
    func getVC() -> UIViewController { return viewController }
}
