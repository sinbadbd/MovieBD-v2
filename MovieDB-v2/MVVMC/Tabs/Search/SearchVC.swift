//
//  SearchVC.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

final class SearchVC: UIViewController, Reusable {
    public var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info()
        view.backgroundColor = .white
     }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Log.info()
        self.navigationController?.navigationBar.topItem?.title = "Search"
    }
}
