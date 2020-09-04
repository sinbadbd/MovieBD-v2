//
//  DashboardVC.swift
//  MovieDB-v2
//
//  Created by Imran on 19/6/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import UIKit

var movieID = 0

class DashboardVC: BaseVC {
    
    let upcommingView = UpcommingMovieView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          isTopbar = false
          resetBase()
        view.backgroundColor = .white
        
        setupMovieUI()
        
        navigationItem.title = "Movie"
        
        print("hello dashboard")
        
        //   setupViews()
        //setupBottomTabBar()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationItem.setHidesBackButton(false, animated: true);
    }
        func setupMovieUI() {
            print("adib")
            //   setContentHeight(height: 3000)
            
            //   upcommingView.frame = CGRect(x: 10, y: 200, width: 32, height: 400)
            contentView.addSubview(upcommingView)
            
         //   upcommingView.translatesAutoresizingMaskIntoConstraints = false
            upcommingView.anchor(top: contentView.topAnchor,
                                 leading: contentView.leadingAnchor,
                                 bottom:nil,
                                 trailing: contentView.trailingAnchor,
                                 padding: .init(top: 60, left: 10, bottom: 0, right: 10),
                                 size: .init(width: upcommingView.frame.width, height: 180)
            )
            // MARK: // Another Solution
            
            //        upcommingView.didSelectCallback = { [weak self] in
            //            guard let weakSelf = self else {return}
            //            let vc = MovieDetailsVC()
            //            weakSelf.navigationController?.pushViewController(vc, animated: true)
            //
            //            //}
            //        }
            //
            
            // MARK: // Another Solution - PERFECT SOLUTION
            upcommingView.callback = { (id) -> Void in
                print("callback - \(id)")
                // print(id)
                let vc = MovieDetailsVC()
                GLOBAL_MOVIE_ID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        
        
        func setupViews(){
        }
        
    
        
}
