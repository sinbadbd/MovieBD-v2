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
    
    let upcommingView     = UpcommingMovieView()
    let discoverMovieView = DiscoverMovieView()
    let popularMovieView  = PopularMovieView()
    let topRatedMovie     = TopRatingMovieView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTopbar = false
//        isShowBottomTab = false
        resetBase()
        view.backgroundColor = .white
        
        setupMovieUI()
        callbackRedirection()
        navigationItem.title = "Movie"
        
        // print("hello dashboard")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    func setupMovieUI() {
        
        contentView.addSubview(upcommingView)
        upcommingView.anchor(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom:nil,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 60, left: 10, bottom: 0, right: 10),
                             size: .init(width: upcommingView.frame.width, height: 180)
        )
        
        contentView.addSubview(discoverMovieView)
        discoverMovieView.anchor(top: upcommingView.bottomAnchor,
                                 leading: contentView.leadingAnchor,
                                 bottom:nil,
                                 trailing: contentView.trailingAnchor,
                                 padding: .init(top: 60, left: 10, bottom: 0, right: 10),
                                 size: .init(width: discoverMovieView.frame.width, height: 180)
        )
        
        
        contentView.addSubview(popularMovieView)
        popularMovieView.anchor(top: discoverMovieView.bottomAnchor,
                                leading: contentView.leadingAnchor,
                                bottom:nil,
                                trailing: contentView.trailingAnchor,
                                padding: .init(top: 60, left: 10, bottom: 0, right: 10),
                                size: .init(width: popularMovieView.frame.width, height: 180)
        )
        contentView.addSubview(topRatedMovie)
        topRatedMovie.anchor(top: popularMovieView.bottomAnchor,
                             leading: contentView.leadingAnchor,
                             bottom:contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 60, left: 10, bottom: 0, right: 10),
                             size: .init(width: topRatedMovie.frame.width, height: 180)
        )

    }
    
    
    
    func  callbackRedirection(){
        // MARK: // Another Solution - PERFECT SOLUTION
        upcommingView.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        discoverMovieView.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        popularMovieView.callback = { (id) -> Void in
            print("callback - \(id)")
            // print(id)
            let vc = MovieDetailsVC()
            GLOBAL_MOVIE_ID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        topRatedMovie.callback = { (id) -> Void in
                   print("callback - \(id)")
                   // print(id)
                   let vc = MovieDetailsVC()
                   GLOBAL_MOVIE_ID = id
                   self.navigationController?.pushViewController(vc, animated: true)
               }
    }
    
    
    
}
