//
//  PlatformVC.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
import Foundation

public enum PlatformTab: Int {
    case home
    case packages
    case rewards
    case services
    case more
}

public extension PlatformTab {
    var string: String { return String(describing: self) }
}



final class PlatformVC: UITabBarController {
    typealias LoadTabAction = ( (PlatformTab) -> Void )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustTabbar()
//        view.backgroundColor = .blue
//        delegate = self
        Log.info()
     }
}
extension PlatformVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
        //if viewController is PackagesVC { requester?.request(to: .load(.packages)); return false }
        //else if viewController is RewardsVC { requester?.request(to: .load(.rewards)); return false }
        //else { return true }
    }
}

// --------------------------------------
// MARK: - Detail Implementation
// --------------------------------------

extension PlatformVC {
    class func getVC() -> PlatformVC {
        let vc = PlatformVC()
        vc.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        vc.tabBar.layer.shadowRadius = 2
        vc.tabBar.layer.shadowOpacity = 0.05
        return vc
    }
    
    public func load(tab: PlatformTab) {
        selectedIndex = tab.rawValue
    }
    
    public func setLocalization() {
        guard let items = tabBar.items else { return }
        items[PlatformTab.home.rawValue].title = "home"//PlatformTab.home.string.localized()
        items[PlatformTab.packages.rawValue].title = "movie"//PlatformTab.packages.string.localized()
        items[PlatformTab.rewards.rawValue].title = "search" //PlatformTab.rewards.string.localized()
        items[PlatformTab.services.rawValue].title = "Tv" //PlatformTab.services.string.localized()
        items[PlatformTab.more.rawValue].title = "profile"//PlatformTab.more.string.localized()
    }
}

// --------------------------------------
// MARK: - Tabbar Appearance
// --------------------------------------

extension PlatformVC {
     private func adjustTabbar() {
        if #available(iOS 13, *) {
            let appearance = tabBar.standardAppearance
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10) as Any
            ]
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.cyan
            
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.blue,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10) as Any
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.red
            tabBar.standardAppearance = appearance
        } else {
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
            tabBar.items?.forEach({ (item) in
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
                let unselectedItem: NSDictionary = [
                    NSAttributedString.Key.foregroundColor: UIColor.gray,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10) as Any
                ]
                let selectedItem: NSDictionary = [
                    NSAttributedString.Key.foregroundColor: UIColor.blue,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10) as Any
                ]
                item.setTitleTextAttributes(unselectedItem as? [NSAttributedString.Key : Any], for: .normal)
                item.setTitleTextAttributes(selectedItem as? [NSAttributedString.Key : Any], for: .selected)
            })
        }
    }
}
