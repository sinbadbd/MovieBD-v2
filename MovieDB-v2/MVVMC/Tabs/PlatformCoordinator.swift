//
//  PlatformCoordinator.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

final class PlatformCoordinator: Coordinator {
    
    private var window: UIWindow?
    var navController: UINavigationController?
    lazy var platformVC = PlatformVC.getVC()
    
    private var homeCo: HomeCoordinator!
    private var tvCo: TvCoordinator! //PackagesCoordinator!
    private var profileCo: ProfileCoordinator!//RewardsCoordinator!
    private var searchCo: SearchCoordinator! //ServicesCoordinator!
    //    private var moreCo: MoreCoordinator!
    var childs: [Coordinator] = []
    
    
    init(window: UIWindow?) {
        self.window = window
        //        delegate = .init()
        navController = UINavigationController(rootViewController: platformVC)
        navController?.navigationBar.isHidden = false
        navController?.setNavigationBarHidden(true, animated: false)
        //        viewModel = PlatformVM()
        //        platformVC.requester = self
        //        platformVC.viewModel = viewModel
        //
        //        InboxManager.addSubscriber(self)
        //
        setupTabCo()
    }
    
    func start() {
        Log.info()
        window?.set(navController)
        setupTabbar()
    }
}


// --------------------------------------
// MARK: - Detail Implementation
// --------------------------------------

extension PlatformCoordinator {
    private func setupTabCo() {
        homeCo = .init(navController: navController)
        tvCo = .init(navController: navController)
        profileCo = .init(navController: navController)
        searchCo = .init(navController: navController)
        //        rewardsCo = .init(requester: self)
        //        servicesCo = .init(requester: self)
        //        moreCo = .init(requester: self)
        //        delegate?.addDelegate(homeCo)
        //        delegate?.addDelegate(packagesCo)
        //        delegate?.addDelegate(rewardsCo)
        //        delegate?.addDelegate(servicesCo)
        //        delegate?.addDelegate(moreCo)
        //        delegate?.addDelegate(viewModel)
        
    }
    
    private func setupTabbar() {
        addTab(
            coord: homeCo,
            normalImage: #imageLiteral(resourceName: "home"),
            selectedImage: #imageLiteral(resourceName: "home"),
            title: "Home"//PlatformTab.home.string.localized()
        )
        addTab(
            coord: tvCo,
            normalImage: #imageLiteral(resourceName: "search"),
            selectedImage: #imageLiteral(resourceName: "search"),
            title: "Tv"//PlatformTab.packages.string.localized()
        )
        addTab(
            coord: profileCo,
            normalImage: #imageLiteral(resourceName: "search"),
            selectedImage: #imageLiteral(resourceName: "search"),
            title: "profile"//PlatformTab.rewards.string.localized()
        )
        addTab(
            coord: searchCo,
            normalImage: #imageLiteral(resourceName: "search"),
            selectedImage: #imageLiteral(resourceName: "search"),
            title: "search" //PlatformTab.services.string.localized()
        )
        //        addTab(
        //            coord: moreCo,
        //            normalImage: #imageLiteral(resourceName: "ic_more"),
        //            selectedImage: #imageLiteral(resourceName: "ic_more_selected"),
        //            title: PlatformTab.more.string.localized()
        //        )
        //
        platformVC.viewControllers = [
            homeCo.getVC(),
            tvCo.getVC(),
            searchCo.getVC(),
            profileCo.getVC(),
            //            moreCo.getVC()
        ]
    }
    
    private func addTab(coord: TabBarItemCoordinator, normalImage: UIImage,
                        selectedImage: UIImage, title: String) {
        let vc = coord.getVC()
        vc.tabBarItem = UITabBarItem(title: title, image: normalImage,
                                     selectedImage: selectedImage)
        
    }
    
    //    private func handleLoadTab(_ tab: PlatformTab) {
    //        if tab == .packages || tab == .rewards, !DataKit.isLoggedIn { handlePackageLandingForGuest(next: tab) }
    //        else { loadTab(tab) }
    //    }
    //
    private func loadTab(_ tab: PlatformTab) {
        platformVC.load(tab: tab)
    }
    
    //    private func handlePackageLandingForGuest(next tab: PlatformTab) {
    //        if viewModel.isCliInProgress { ViewKit.showToast(type: .wait); return }
    //        ViewKit.showLoginRequired(message: "login_to_pack_purchase".localized()) { [weak self] in
    //            guard let `self` = self else { return }
    //            if self.viewModel.isCliOn() {
    //                self.tryCliLogin(completion: {
    //                    [weak self] in self?.loadTab(tab)
    //
    //                })
    //            } else {
    //                self.loadAuth(completion: { [weak self] in
    //                    self?.loadTab(tab)
    //                })
    //            }
    //        }
    //    }
    //
    func addChild(_ coord: Coordinator) { childs.append(coord) }
    
    func removeChild<T: Coordinator>(_: T.Type) {
        let child = childs.compactMap { $0 is T ? $0 : nil }.first
        child?.stop?()
        childs = childs.compactMap { $0 is T ? nil : $0 }
    }
    
    func popTo<T: Coordinator>(_: T.Type) {
        var newChilds: [Coordinator] = []
        for child in childs {
            newChilds.append(child)
            if child is T { break }
        }
        
        if let vc = newChilds.last?.getVC?() {
            childs = newChilds
            navController?.popToViewController(vc, animated: true)
        }
    }
    
    //    func removeAllChild(silently: Bool = false) {
    //        navController?.popToRootViewController(animated: !silently)
    //
    //        homeCo.silentRemoveChild()
    //        packagesCo.silentRemoveChild()
    //        rewardsCo.silentRemoveChild()
    //        servicesCo.silentRemoveChild()
    //        moreCo.silentRemoveChild()
    //
    //        PaymentKit.reset()
    //        SecurityKit.reset()
    //
    //        childs = []
    //    }
    
    func isNew<T: Coordinator>(_: T.Type) -> Bool {
        return childs.compactMap { $0 is T ? $0 : nil }.first == nil
    }
}

//extension PlatformCoordinator {
//    func authorize(completion: @escaping Completion) {
//        if DataKit.isLoggedIn { completion() }
//        else if viewModel.isCliOn() {
//            tryCliLogin { completion() }
//        } else {
//            loadAuth { completion() }
//        }
//    }
//}

