//
//  TvVC.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

final class TvVC: UIViewController, Reusable {
    public var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info()
        view.backgroundColor = .white
    }
    
}
